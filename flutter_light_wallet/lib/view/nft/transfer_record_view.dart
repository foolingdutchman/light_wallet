import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_nft_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';
import 'package:flutter_light_wallet/view/nft/nft_data_store.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class TransferRecordView extends StatefulWidget {
  const TransferRecordView({Key? key}) : super(key: key);

  @override
  _TransferRecordViewState createState() =>
      _TransferRecordViewState('transfer-record-view-detecotr');
}

class _TransferRecordViewState extends BaseNftPageState<TransferRecordView> {
  _TransferRecordViewState(String observerKey) : super(observerKey);

  List<TransferRecord> records = NftDataStore.myTransferRecords;

  @override
  void afterCaniterInted() {
    if (!NftDataStore.isTransferRecordFresh) {
      _getRecords();
    }
  }

  _getRecords() async {
    SmartDialog.showLoading();
    await NftDataStore.fetchMyTransferRecordsData();
    SmartDialog.dismiss();

    setState(() {
      records = NftDataStore.myTransferRecords;
    });
  }

  @override
  Widget constructView(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Expanded(
          child: Container(
            child: LiquidPullToRefresh(
              height: 50,
              color: Colors.transparent,
              showChildOpacityTransition: false,
              animSpeedFactor: 2,
              onRefresh: () {
                return _refreshData();
              },
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
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
                                        S.of(context).token_id,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        records[position].nftPrincipal.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        records[position].from!.toString() ==
                                                InstanceStore.currentWallet!.principal
                                            ? S.of(context).to
                                            : S.of(context).from,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        records[position].from!.toString() ==
                                                InstanceStore.currentWallet!.principal
                                            ? records[position].to == null
                                                ? S.of(context).burn
                                                : records[position].to!.toString()
                                            : records[position].from!.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
                    itemCount: records.length),
              ),
            ),
          ),
        ));
  }

  @override
  void hanldEvent(Event event) {
    if (event is NftDataStoreUpdateEvent) {
      setState(() {
        records = NftDataStore.myTransferRecords;
      });
    }
  }

  Future<void> _refreshData()async {
   await _getRecords();
  }
}
