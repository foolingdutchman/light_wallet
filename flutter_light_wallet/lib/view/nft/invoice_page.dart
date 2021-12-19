import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_nft_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/icp_account_utils.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';
import 'package:flutter_light_wallet/view/nft/nft_page.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class InvociePage extends StatefulWidget {
  const InvociePage({Key? key, required this.invoiceData}) : super(key: key);
  final Invoice invoiceData;

  @override
  _InvociePageState createState() =>
      _InvociePageState("invoice_detector_key", this.invoiceData);
}

class _InvociePageState extends BaseNftPageState<InvociePage> {
  _InvociePageState(String observerKey, this.invoiceData) : super(observerKey);
  Invoice invoiceData;

  @override
  void afterCaniterInted() {
    // TODO: implement afterCaniterInted
  }

  @override
  Widget constructView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 80, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Invoice",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Container(
                height: 480,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 0.5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(5, 5),
                        blurRadius: 10,
                        color: Colors.black26),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      invoiceData.isUncheckInvoice()
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Invoice No:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 1,
                                  )),
                                  Text(invoiceData.id!.toString() + ""),
                                ],
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Text(
                              "Invoice Type:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                child: Container(
                              height: 1,
                            )),
                            Text(invoiceData.isMintInvoice() ? "#Mint" : "#Purchase",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Text(
                              "Fee:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                child: Container(
                              height: 1,
                            )),
                            Text(ICPAccountUtils.fromICPBigInt2Amount(
                                        invoiceData.charge!)
                                    .toString() +
                                " ICP"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Text(
                          "Counter Address",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Center(child: Text(invoiceData.counterAddress)),
                      ),
                      invoiceData.isMintInvoice()
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Purchase Price:",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: Container(
                                        height: 1,
                                      )),
                                      Text(ICPAccountUtils.fromICPBigInt2Amount(
                                                  invoiceData.amount!)
                                              .toString() +
                                          " ICP"),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  child: Text(
                                    "Seller Address",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Center(
                                      child: Text(invoiceData.receiptAddress!)),
                                ),
                              ],
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10.0),
                        child: Row(
                          children: [
                            Text(
                              "Issue Date:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                child: Container(
                              height: 1,
                            )),
                            Text(StringUtil.longTimeStampToDateString(
                                invoiceData.isUncheckInvoice()
                                    ? invoiceData.timeStamp!.toInt()
                                    : invoiceData.checktimeStamp!.toInt())),
                          ],
                        ),
                      ),
                      Divider(
                        height: 30,
                        thickness: 0.5,
                        color: Color(0x22000000),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                        child: Row(
                          children: [
                            Text(
                              "Total Amount:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                child: Container(
                              height: 1,
                            )),
                            Text(
                              ICPAccountUtils.fromICPBigInt2Amount(
                                  invoiceData.isMintInvoice()
                                              ? invoiceData.charge!
                                              : invoiceData.charge! +
                                                  invoiceData.amount!)
                                      .toString() +
                                  " ICP",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
             ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width - 50, 50)),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff39267e))),
                    onPressed: () {
                      onButtonPressed(context);
                    },
                    child: Text( invoiceData.isUncheckInvoice()? "Pay for the Bill":"Nft Detail"),
                  )

          ],
        ),
      ),
    );
  }

  @override
  void hanldEvent(Event event) {
    // TODO: implement hanldEvent
  }



  void onButtonPressed(BuildContext context) async {
    if(invoiceData.isUncheckInvoice()){
      if (invoiceData.isMintInvoice()) {
        SmartDialog.showLoading();
        BigInt blockHeight = await ICPAccountUtils.transfer(
            InstanceStore.currentWallet,
            invoiceData.counterAddress,
            ICPAccountUtils.fromICPBigInt2Amount(invoiceData.charge!).toString());
        SmartDialog.dismiss();
        SmartDialog.showToast("Transaction has been made...");
        Navigator.pop(context, [blockHeight]);
      }else{
        SmartDialog.showLoading();
        BigInt blockHeight1 = await ICPAccountUtils.transfer(
            InstanceStore.currentWallet,
            invoiceData.counterAddress,
            ICPAccountUtils.fromICPBigInt2Amount(invoiceData.charge!).toString());
        BigInt blockHeight2 = await ICPAccountUtils.transfer(
            InstanceStore.currentWallet,
            invoiceData.receiptAddress!,
            ICPAccountUtils.fromICPBigInt2Amount(invoiceData.amount!).toString());
        Navigator.pop(context, [blockHeight1,blockHeight2]);
      }

    }else{
      Navigator.push(context, SlideRightRoute(page: NftPage(principal: invoiceData.nft_principal!.toString())));

    }

  }
}
