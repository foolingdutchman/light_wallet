
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/icp_account_utils.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'password_page.dart';
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
  }

  void onButtonPressed() {
    if (isValidRequest()) _verifyPasswordForTransaction();
  }

  bool isValidRequest() {
    if (!StringUtil.isICPAddress(_address.text)) {
      StringUtil.showToast('请输入有效的ICP地址');
      return false;
    } else if (_amount.text == '' ||
        (double.tryParse(_amount.text) ?? 0) >
            wallet!.getAvalidTransferAmount() ||
        (double.tryParse(_amount.text) ?? 0) == 0) {
      StringUtil.showToast('请输入有效转账金额');
      return false;
    }
    return true;
  }

  void _verifyPasswordForTransaction() async {
    String result = '';
    if (InstanceStore.deviceInfo!.isGuesturePrintPasswordActive) {
      result = await Navigator.push(
          context,
          SlideRightRoute(
              page: GuesturePasswordPage(
            type: 'verify_password',
            wallet: InstanceStore.currentWallet,
          )));
    } else {
      result = await Navigator.push(context,
          SlideRightRoute(page: PasswordPage(type: 'verify_password')));
    }

    if (result == 'OK') {
      StringUtil.showToast('密码已验证！');
      //_proceedTransaction(_amount.text, _address.text);
    }
  }

  void _proceedTransaction(String amount, String address) async {
    SmartDialog.showLoading();
    String result = await ICPAccountUtils.transfer(wallet, address, amount);
    SmartDialog.dismiss();
  }

  @override
  Widget constructView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 80, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '转账',
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
                '当前地址',
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
                padding: EdgeInsets.all(15),
                child: Expanded(
                    child: Text(
                  wallet!.address,
                  style: TextStyle(color: Colors.black45),
                )),
              ),
              Text(
                '转账数量',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '数量',
                        labelStyle: TextStyle(
                          color: Colors.pink,
                          fontSize: 12,
                        ),
                        hintText: '数量',
                        suffix: InkWell(
                          onTap: () {
                            _maxAmountClick();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 5, left: 5, right: 5),
                            child: Container(
                              child: Text(
                                '最大金额',
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
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      controller: _amount,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  children: [
                    Text('余额：' + wallet!.getICPBalance().toString()),
                    Expanded(child: Container())
                  ],
                ),
              ),
              Text(
                '收款地址',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: '收款地址',
                  labelStyle: TextStyle(
                    color: Colors.pink,
                    fontSize: 12,
                  ),
                  hintText: '收款地址',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink,
                    ),
                  ),
                ),
                controller: _address,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: Row(
                  children: [
                    Text('Fee: 0.0001 ICP'),
                    Expanded(child: Container())
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width - 50, 50))),
                onPressed: onButtonPressed,
                child: Text('确定'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void hanldEvent(Event event) {
    if (event is SwitchWalletEvent || event is DeleteWalletEvent) {
      setState(() {
        wallet = InstanceStore.currentWallet;
      });
    }
  }

  @override
  void onFirstVisible() {}

  @override
  void onVisible() {}
}
