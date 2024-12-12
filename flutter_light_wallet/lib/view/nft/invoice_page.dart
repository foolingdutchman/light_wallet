import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_nft_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/icp_account_utils.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';
import 'package:flutter_light_wallet/utils/verification_util.dart';
import 'package:flutter_light_wallet/view/nft/nft_page.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key, required this.invoiceData}) : super(key: key);
  final Invoice invoiceData;

  @override
  _InvoicePageState createState() =>
      _InvoicePageState("invoice_detector_key", this.invoiceData);
}

class _InvoicePageState extends BaseNftPageState<InvoicePage> {
  _InvoicePageState(String observerKey, this.invoiceData) : super(observerKey);
  Invoice invoiceData;

  @override
  void afterCaniterInted() {
    // TODO: implement afterCaniterInted
  }

  @override
  Widget constructView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 80, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).invoice,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black12, width: 0.5),
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
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              S.of(context).invoice_no + ":",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Expanded(
                                                child: Container(
                                              height: 1,
                                            )),
                                            Text(invoiceData.id!.toString() +
                                                ""),
                                          ],
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        S.of(context).invoice_type + ":",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: Container(
                                        height: 1,
                                      )),
                                      Text(
                                        invoiceData.getTypeString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        S.of(context).fee + " :",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
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
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  child: Text(
                                    S.of(context).token_id,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Color(0x08000000),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Center(
                                      child: Text(
                                    invoiceData.nft_principal.toString(),
                                    style: TextStyle(color: Colors.black54),
                                  )),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  child: Text(
                                    S.of(context).counter_address + ":",
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
                                      child: Text(invoiceData.counterAddress)),
                                ),
                                invoiceData.type != InvoiceType.PURCHASE
                                    ? Container()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0, top: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  S.of(context).purchase_price +
                                                      ":",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                  height: 1,
                                                )),
                                                Text(ICPAccountUtils
                                                            .fromICPBigInt2Amount(
                                                                invoiceData
                                                                    .amount!)
                                                        .toString() +
                                                    " ICP"),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 5),
                                            child: Text(
                                              S.of(context).seller_address +
                                                  ":",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                            ),
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Center(
                                                child: Text(invoiceData
                                                    .receiptAddress!)),
                                          ),
                                        ],
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 10.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        S.of(context).issue_date + ":",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: Container(
                                        height: 1,
                                      )),
                                      Text(StringUtil.longTimeStampToDateString(
                                          invoiceData.isUncheckInvoice()
                                              ? invoiceData.timeStamp!.toInt()
                                              : invoiceData.checktimeStamp!
                                                  .toInt())),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 30,
                                  thickness: 0.5,
                                  color: Color(0x22000000),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0, top: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        S.of(context).total_amount + ":",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                          child: Container(
                                        height: 1,
                                      )),
                                      Text(
                                        ICPAccountUtils.fromICPBigInt2Amount(
                                                    invoiceData.type !=
                                                            InvoiceType.PURCHASE
                                                        ? invoiceData.charge!
                                                        : invoiceData.charge! +
                                                            invoiceData.amount!)
                                                .toString() +
                                            " ICP",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        invoiceData.isUncheckInvoice()
                            ? Container()
                            : Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 80.0),
                                  child: Image(
                                      width: 150,
                                      height: 150,
                                      image: AssetImage(
                                          'assets/images/approved.png')),
                                )),
                      ],
                    ),
                  ),
                  invoiceData.type == InvoiceType.BURN&&!invoiceData.isUncheckInvoice()? Container(): ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: WidgetStateProperty.all(
                            Size(MediaQuery.of(context).size.width - 50, 50)),
                        backgroundColor:
                            WidgetStateProperty.all(Color(0xff39267e))),
                    onPressed: () {
                      onButtonPressed(context);
                    },
                    child: Text(invoiceData.isUncheckInvoice()
                        ? S.of(context).pay_the_bill
                        : S.of(context).nft_detail),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
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

  bool checkBlanceValid() {
    return InstanceStore.currentWallet!.getICPBalance() >=
        ICPAccountUtils.fromICPBigInt2Amount(invoiceData.totalAmount()) +
            0.0001;
  }

  void onButtonPressed(BuildContext context) async {
    if (invoiceData.isUncheckInvoice()) {
      if (!checkBlanceValid()) {
        SmartDialog.showToast(S.current.hint_icp_not_enough);
        return;
      }

      String result = await VerificationUtils.verifyProcess(context);
      SmartDialog.showLoading();
      if (result == "OK") {
        switch (invoiceData.type) {
          case InvoiceType.MINT:
          case InvoiceType.BURN:
          case InvoiceType.TRANSFER:
            BigInt blockHeight = await ICPAccountUtils.transfer(
                InstanceStore.currentWallet,
                invoiceData.counterAddress,
                ICPAccountUtils.fromICPBigInt2Amount(invoiceData.charge!)
                    .toString());
            await SmartDialog.dismiss();
            SmartDialog.showToast("Transaction has been made...");
            Navigator.pop(context, [blockHeight]);
            break;
          case InvoiceType.PURCHASE:
            BigInt blockHeight1 = await ICPAccountUtils.transfer(
                InstanceStore.currentWallet,
                invoiceData.counterAddress,
                ICPAccountUtils.fromICPBigInt2Amount(invoiceData.charge!)
                    .toString());
            BigInt blockHeight2 = await ICPAccountUtils.transfer(
                InstanceStore.currentWallet,
                invoiceData.receiptAddress!,
                ICPAccountUtils.fromICPBigInt2Amount(invoiceData.amount!)
                    .toString());
            await SmartDialog.dismiss();
            SmartDialog.showToast("Transaction has been made...");
            Navigator.pop(context, [blockHeight1, blockHeight2]);
            break;
        }
      }
    } else {
      Navigator.push(
          context,
          SlideRightRoute(
              page: NftPage(principal: invoiceData.nft_principal!.toString())));
    }
  }
}
