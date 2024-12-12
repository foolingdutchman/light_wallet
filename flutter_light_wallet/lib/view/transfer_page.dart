import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/icp_account_utils.dart';
import 'package:flutter_light_wallet/utils/local_auth_util.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';
import 'package:flutter_light_wallet/utils/verification_util.dart';
import 'package:flutter_light_wallet/view/scan_page.dart';
import 'package:flutter_light_wallet/view/transfer_complete_page.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'password_page.dart';
import 'guesture_password.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  _TransferPageState createState() =>
      _TransferPageState('transfer-page-detector');
}

class _TransferPageState extends BasePageState<TransferPage> {
  TextEditingController _amount = TextEditingController();
  TextEditingController _address = TextEditingController();
  FocusNode _addressFusNode = FocusNode();
  bool _isAddressFocus = false;
  Wallet? wallet;

  _TransferPageState(String observerKey) : super(observerKey);

  void _maxAmountClick() {
    setState(() {
      _amount.text = wallet!.getAvalidTransferAmount().toString();
    });
  }

  @override
  void initState() {
    wallet = InstanceStore.currentWallet;
    super.initState();
    this._amount.text = '';
    this._address.text = '';
    _addressFusNode.addListener(() {
      setState(() {
        _isAddressFocus = _addressFusNode.hasFocus;
      });
    });
    super.initState();
  }

  void onButtonPressed() {
    if (isValidRequest()) _verifyPasswordForTransaction();
    // _verifyFingerprintPassword();
  }

  bool isValidRequest() {
    if (!StringUtil.isICPAddress(_address.text)) {
      StringUtil.showToast(S.of(context).invalid_address_hint);
      return false;
    } else if (_amount.text == '' ||
        (double.tryParse(_amount.text) ?? 0) >
            wallet!.getAvalidTransferAmount() ||
        (double.tryParse(_amount.text) ?? 0) == 0) {
      StringUtil.showToast(S.of(context).invalid_amount_hint);
      return false;
    }
    return true;
  }

  void _verifyPasswordForTransaction() async {
    String result = await VerificationUtils.verifyProcess(context);

    if (result == 'OK') {
      StringUtil.showToast(S.current.password_verified);
      _proceedTransaction(_amount.text, _address.text);
    }
  }


  void _proceedTransaction(String amount, String address) async {
    SmartDialog.showLoading();
    ICPAccountUtils.transfer(wallet, address, amount).then((value) {
      SmartDialog.dismiss();

      InstanceStore.currentWallet!.getICP().balance =
          (InstanceStore.currentWallet!.getICPBalance() * 10000 -
                  (num.parse(amount) * 10000).round() -
                  1) /
              10000;
      EventBusUtil.fire(TransactionEvent());
      Navigator.push(
          context,
          SlideRightRoute(
              page: TransactionCompletePage(
            height: value,
          )));
    }).onError((error, stackTrace) {
      SmartDialog.dismiss();
    });
  }

  void _scanAddress() async {
    print("clicked scan...");
    FocusScope.of(context).requestFocus(FocusNode());
    var result =
        await Navigator.push(context, SlideRightRoute(page: ScanPage()));
    setState(() {
      _address.text = result == null ? "" : result;
    });
  }

  @override
  Widget constructView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 80, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).transfer,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                S.of(context).current_address,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                margin: EdgeInsets.only(top: 10, bottom: 30),
                height: 80,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15),
                child: Text(
                  wallet!.address,
                  style: TextStyle(color: Colors.black45),
                ),
              ),
              Text(
                S.of(context).transfer_amount,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: S.of(context).amount,
                  suffix: InkWell(
                    onTap: () {
                      _maxAmountClick();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 5, left: 5, right: 5),
                      child: Container(
                        child: Text(
                          S.of(context).max_amount,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink,
                    ),
                  ),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _amount,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  children: [
                    Text(S.of(context).balance +
                        ":" +
                        wallet!.getICPBalance().toString() +
                        " ICP"),
                    Expanded(child: Container())
                  ],
                ),
              ),
              Text(
                S.of(context).receipt_address,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isAddressFocus ? Colors.blue : Colors.black26,
                    width: _isAddressFocus ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          focusNode: _addressFusNode,
                          decoration: InputDecoration(
                            hintText: S.of(context).receipt_address,
                            border: InputBorder.none,
                          ),
                          controller: _address,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _scanAddress();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Icon(
                          Icons.qr_code_scanner,
                          size: 28,
                          color: Color(0xff39267e),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: Row(
                  children: [
                    Text(S.of(context).fee + ': 0.0001 ICP'),
                    Expanded(child: Container())
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width - 50, 50)),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff39267e))),
                onPressed: onButtonPressed,
                child: Text(S.of(context).confirm),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void hanldEvent(Event event) {
    if (event is SwitchWalletEvent ||
        event is DeleteWalletEvent ||
        event is TransactionEvent) {
      setState(() {
        wallet = InstanceStore.currentWallet;
      });
    } else if (event is ClearWalletEvent) {
      // Navigator.pop(context);
    }
  }

  @override
  void onFirstVisible() {}

  @override
  void onVisible() {}
}
