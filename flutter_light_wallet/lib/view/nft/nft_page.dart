import 'dart:io';

import 'package:agent_dart/agent_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_nft_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/canister_util.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/file_util.dart';
import 'package:flutter_light_wallet/utils/icp_account_utils.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';
import 'package:flutter_light_wallet/view/nft/nft_transfer_page.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'invoice_page.dart';
import 'nft_meta_page.dart';

class NftPage extends StatefulWidget {
  final String principal;
  final NftData? nftData;
  final Order? order;

  const NftPage({Key? key, required this.principal, this.nftData, this.order})
      : super(key: key);

  @override
  _NftPageState createState() =>
      _NftPageState('nft-page-detector', principal, nftData: this.nftData);
}

class _NftPageState extends BaseNftPageState<NftPage> {
  _NftPageState(String observerKey, this._principal, {this.nftData})
      : super(observerKey);
  NftData? nftData;
  Order? order;
  String _principal;
  double _price = 0;
  File? _file;
  TextEditingController _priceControler = TextEditingController();

  @override
  Widget constructView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 80, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       S.of(context).nft_detail,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).token_index +
                                  ": #" +
                                  (nftData == null
                                      ? ""
                                      : nftData!.id.toString()),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Text(
                          S.of(context).token_id,
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
                        child: Center(
                            child: Text(_principal != ""
                                ? _principal
                                : nftData!.principal.toString())),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          nftData == null ? "" : nftData!.title,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          nftData == null ? "" : "  " + nftData!.desc,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                            ),
                          ),
                          Text(
                              nftData == null
                                  ? ""
                                  : S.of(context).author +
                                      " : " +
                                      nftData!.author +
                                      ".",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      _file == null
                          ? Container()
                          : InkWell(
                            onTap: (){
                              Navigator.push(context,SlideRightRoute(page: NftMetaPage(nft: nftData!,)));
                            },
                            child: Image.file(
                                _file!,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 4 / 3,
                                fit: BoxFit.fitWidth,
                              ),
                          ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Text(
                          S.of(context).owner_id,
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
                        child: Center(
                            child: Text(nftData == null
                                ? ""
                                : nftData!.owner.toString())),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Text(
                          S.of(context).creator_principal,
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
                        child: Center(
                            child: Text(nftData == null
                                ? ""
                                : nftData!.creater.toString())),
                      ),
                      isOwnerView()
                          ? Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          fixedSize: WidgetStateProperty.all(
                                              Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      50,
                                                  50)),
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Color(0xff39267e))),
                                      onPressed: () {
                                        onTransferPressed(context);
                                      },
                                      child: Text(S.of(context).transfer),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          fixedSize: WidgetStateProperty.all(
                                              Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      50,
                                                  50)),
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Color(0xfff3ab39))),
                                      onPressed: () {
                                        onBurnPressed(context);
                                      },
                                      child: Text(S.of(context).burn),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                      Container(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 30, right: 30),
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, -3),
                      blurRadius: 3,
                      color: Colors.black26),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(isNftSell() ? S.of(context).price + ":" : ""),
                  ),
                  Expanded(
                    child: Text(isNftSell() ? _price.toString() + " ICP" : ""),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      isOwnerView()
                          ? isNftSell()
                              ? SmartDialog.show(
                                  widget: updateOrderView(context))
                              : SmartDialog.show(
                                  widget: createOrderView(context, true))
                          : isNftSell()
                              ? buyNft()
                              : {};
                    },
                    child: Text(isOwnerView()
                        ? (isNftSell()
                            ? S.of(context).update_sell
                            : S.of(context).sell)
                        : (isNftSell()
                            ? S.of(context).buy
                            : S.of(context).not_sell)),
                    style: ButtonStyle(
                      backgroundColor: !isOwnerView() && !isNftSell()
                          ? WidgetStateProperty.all(Color(0x11000000))
                          : WidgetStateProperty.all(Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createOrderView(BuildContext context, bool isCreate) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width - 50,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
                offset: Offset(5, 5), blurRadius: 10, color: Colors.black12),
          ]),
      child: Center(
        child: Column(
          children: [
            Text(
              isCreate ? S.of(context).set_price : S.of(context).change_price,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                controller: _priceControler,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: S.of(context).price,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink,
                    ),
                  ),
                  suffix: Text('ICP'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  isCreate ? makeOrder() : updateOrder();
                },
                child: Text(S.of(context).confirm),
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(
                      Size(MediaQuery.of(context).size.width - 50, 50)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget updateOrderView(BuildContext context) {
    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width - 50,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
                offset: Offset(5, 5), blurRadius: 10, color: Colors.black12),
          ]),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ElevatedButton(
                onPressed: () {
                  SmartDialog.dismiss();
                  SmartDialog.show(widget: createOrderView(context, false));
                },
                child: Text(S.of(context).change_price),
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(
                      Size(MediaQuery.of(context).size.width - 60, 50)),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                cancelOrder();
              },
              child: Text(S.of(context).cancel_sell),
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(
                    Size(MediaQuery.of(context).size.width - 60, 50)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget burnTokenView(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width - 50,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
                offset: Offset(5, 5), blurRadius: 10, color: Colors.black12),
          ]),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Icon(
                Icons.warning_rounded,
                color: Colors.red,
                size: 48,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Text(
                S.of(context).hint_burn_token,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _burnToken(context);
              },
              child: Text(S.of(context).confirm),
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(
                    Size(MediaQuery.of(context).size.width - 60, 50)),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isNftSell() {
    return order != null;
  }

  bool isOwnerView() {
    return nftData != null &&
        nftData!.owner.toString() ==
            InstanceStore.currentWallet!.principal.toString();
  }

  @override
  void hanldEvent(Event event) {
    if (event is TransferNftEvent || event is BurnNftEvent) {
      print("event listened!...");
      final current = ModalRoute.of(context);
      Navigator.removeRoute(context, current!);
    }
  }

  _setNftData() async {
    SmartDialog.showLoading();
    _file = await FileUtil.writeBytestoFile(
        nftData!.principal.toString() + 'thumbnail',
        nftData!.mediaType,
        (nftData!.thumbnail)!);
    setState(() {});
    SmartDialog.dismiss();
  }

  Future<void> fetch() async {
    // initialize counter, change canister id here
    SmartDialog.showLoading();

    // get nft data below
    nftData = await CanisterUtil.walletCanister!.getNft(_principal);

    _file = await FileUtil.writeBytestoFile(
        _principal + 'thumbnail', nftData!.mediaType, (nftData!.thumbnail)!);
    setState(() {});

    SmartDialog.dismiss();
  }

  @override
  void afterCaniterInted() {
    if (nftData != null)
      _setNftData();
    else
      fetch();

    if (order != null) {
      setState(() {
        _price = ICPAccountUtils.fromICPBigInt2Amount(order!.price!);
      });
    } else {
      _fetchOrder();
    }
  }

  _fetchOrder() async {
    SmartDialog.showLoading();
    order = await walletCanister!.getNftorder(Principal.fromText(_principal));
    SmartDialog.dismiss();

    if (order != null) {
      EventBusUtil.fire(OrderNftEvent(order!));
      setState(() {
        _price = ICPAccountUtils.fromICPBigInt2Amount(order!.price!);
      });
    }
  }

  buyNft() async {
    SmartDialog.showLoading();
    Invoice? invoice = await walletCanister!.claimPurchaseInvoice(order!);
    SmartDialog.dismiss();
    if (invoice != null) {
      List<BigInt> blockHeights = await Navigator.push(
          context, SlideRightRoute(page: InvoicePage(invoiceData: invoice)));
      SmartDialog.showLoading();
      var checkInvoice = await walletCanister!
          .confirmOrder(nftData!.principal!, invoice, blockHeights);
      await SmartDialog.dismiss();
      if (checkInvoice != null) {
        EventBusUtil.fire(TransferNftEvent(checkInvoice));
        Navigator.pushReplacement(context,
            SlideRightRoute(page: InvoicePage(invoiceData: checkInvoice)));
      }
    }
  }

  makeOrder() async {
    SmartDialog.dismiss();
    SmartDialog.showLoading();
    var isCreate = await walletCanister!
        .makeOrder(nftData!.principal!, double.parse(_priceControler.text));
    SmartDialog.dismiss();
    if (isCreate) {
      _fetchOrder();
    }
  }

  updateOrder() async {
    SmartDialog.dismiss();
    SmartDialog.showLoading();
    var isUpdate = await walletCanister!
        .updateOrder(nftData!.principal!, double.parse(_priceControler.text));
    SmartDialog.dismiss();
    if (isUpdate) {
      _fetchOrder();
    }
  }

  void cancelOrder() async {
    SmartDialog.showLoading();
    var isCancel = await walletCanister!.cancelOrder(nftData!.principal!);
    SmartDialog.dismiss();
    if (isCancel) {
      EventBusUtil.fire(CancelOrderEvent(nftData!.principal!));
      setState(() {
        order = null;
      });
    }
  }

  void onTransferPressed(BuildContext context) async {
    Navigator.push(
        context,
        SlideRightRoute(
            page: NftTransferPage(
          nftData: nftData,
        )));
  }

  void onBurnPressed(BuildContext context) async {
    SmartDialog.show(widget: burnTokenView(context));
  }

  void _burnToken(BuildContext context) async {
    SmartDialog.dismiss();

    SmartDialog.showLoading();
    Invoice? inv = await walletCanister!.claimBurnInvoice(nftData!.principal!);
    SmartDialog.dismiss();
    if (inv != null) {
      List<BigInt> blocks = await Navigator.push(
          context,
          SlideRightRoute(
              page: InvoicePage(
            invoiceData: inv,
          )));
      SmartDialog.showLoading();
      Invoice? checkInv =
          await walletCanister!.burnToken(nftData!.principal!, inv, blocks[0]);
      await SmartDialog.dismiss();
      if (checkInv != null) {
        EventBusUtil.fire(BurnNftEvent(checkInv));
        Navigator.pushReplacement(
            context,
            SlideRightRoute(
                page: InvoicePage(
              invoiceData: checkInv,
            )));
      }
    }
  }
}
