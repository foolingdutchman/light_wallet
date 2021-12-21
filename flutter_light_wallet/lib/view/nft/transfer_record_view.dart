

import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_nft_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class TransferRecordView extends StatefulWidget {
  const TransferRecordView({Key? key}) : super(key: key);

  @override
  _TransferRecordViewState createState() => _TransferRecordViewState('transfer-record-view-detecotr');
}

class _TransferRecordViewState extends BaseNftPageState<TransferRecordView> {
  _TransferRecordViewState(String observerKey) : super(observerKey);

  List<TransferRecord> records=[];



  @override
  void afterCaniterInted() {
    if(isCanisterInit){
      _getRecords();
    }
  }

  _getRecords() async{
    SmartDialog.showLoading();
    List<TransferRecord> list = await walletCanister!.getOwnTransferRecord();
    SmartDialog.dismiss();
    if(list.length !=0) {
      records.clear();
      records.addAll(list);
      setState(() {

      });
    }
  }

  @override
  Widget constructView(BuildContext context) {

    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:  Expanded(
          child: ListView.separated(
              itemBuilder: (context, position) => InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     SlideRightRoute(
                  //         page: InvociePage(
                  //           invoiceData:
                  //           invoices![position],
                  //         )));
                },
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [


                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              top: 10,
                              bottom: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Principal Id",

                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(records![position].nftPrincipal.toString(),maxLines: 2, overflow: TextOverflow.ellipsis,),
                                Text(
                                  records![position].from!.toString() == InstanceStore.currentWallet!.principal ? "To:":"From:",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(records[position].from!.toString() == InstanceStore.currentWallet!.principal?
                                records[position].to==null?"Burn":records[position].to!.toString():
                                records[position].from!.toString()
                                  ,maxLines: 1,
                                  overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, position) => new Divider(
                height: 1,
                color: Colors.black26,
              ),
              itemCount:  records.length),
        )
    );
  }

  @override
  void hanldEvent(Event event) {
    if(event is TransferNftEvent || event is MintNftEvent || event is BurnNftEvent){
      _getRecords();
    }

  }
}
