

import 'package:agent_dart/agent_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_nft_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/icp_account_utils.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';
import 'package:flutter_light_wallet/view/nft/invoice_page.dart';
import 'package:flutter_light_wallet/view/scan_page.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class NftTransferPage extends StatefulWidget {
  const NftTransferPage({Key? key ,required this.nftData } ) : super(key: key);
  final NftData? nftData;

  @override
  _NftTransferPageState createState() => _NftTransferPageState("nft-transfer-page-detector",this.nftData);
}

class _NftTransferPageState extends BaseNftPageState<NftTransferPage> {
  _NftTransferPageState(String observerKey ,this.nftData) : super(observerKey);
  NftData? nftData;
  TextEditingController _address = TextEditingController();
  FocusNode _addressFusNode = FocusNode();
  bool _isAddressFocus = false;

  @override
  void initState() {
    // TODO: implement initState
    this._address.text = '';
    _addressFusNode.addListener(() {
      setState(() {
        _isAddressFocus = _addressFusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  void afterCaniterInted() {
    // TODO: implement afterCaniterInted
  }

  @override
  Widget constructView(BuildContext context) {
    // TODO: implement constructView
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
               "Token Principal",
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
                  nftData!.principal.toString(),
                  style: TextStyle(color: Colors.black45),
                ),
              ),


              Text(
               "Receipt Principal",
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
                    Text(S.of(context).fee + ': 0.01 ICP'),
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
                onPressed: (){
                  _claimTransferInvoice(context);
                },
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
    // TODO: implement hanldEvent
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

  void _claimTransferInvoice(BuildContext context)async {
    Principal? p =ICPAccountUtils.checkValidPrincipal(_address.text);
    if(p!=null){
      Invoice? invoice = await walletCanister!.claimTransferInvoice(nftData!.principal!);
       var blockHeight=await  Navigator.push(context, SlideRightRoute(page: InvoicePage(invoiceData: invoice!,)));
       SmartDialog.showLoading();
      Invoice? cheInv = await walletCanister!.transferToken(p, nftData!.principal!, invoice!, blockHeight[0]);
      await SmartDialog.dismiss();
      if(cheInv !=null){
        print(" go to Invoice page...");
        Navigator.pushReplacement(context, SlideRightRoute(page: InvoicePage(invoiceData: cheInv!,)));
        EventBusUtil.fire(TransferNftEvent());
      }

    }else{
      SmartDialog.showToast("Invalid principal...");
    }
  }
}
