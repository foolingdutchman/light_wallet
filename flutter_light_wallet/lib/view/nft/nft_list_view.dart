import 'dart:io';
import 'package:agent_dart/protobuf/ic_ledger/pb/v1/types.pb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_nft_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/file_util.dart';
import 'package:flutter_light_wallet/utils/icp_account_utils.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';
import 'package:flutter_light_wallet/view/nft/nft_data_store.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'nft_page.dart';

class NftDataListView extends StatefulWidget {
  const NftDataListView({Key? key, required this.isOwnList}) : super(key: key);
  final bool isOwnList;

  @override
  _NftDataListViewState createState() => _NftDataListViewState(
      this.isOwnList ? "nft-list-page-detector" : "my-list-page-detector",
      this.isOwnList);
}

class _NftDataListViewState extends BaseNftPageState<NftDataListView> {
  int page = 1;
  List<NftDataWithOrder>? nfts;
  List<File> thumbnails = [];
  bool isOwnList;

  _NftDataListViewState(String observerKey, this.isOwnList)
      : super(observerKey);

  @override
  void afterCaniterInted() {
    // TODO: implement afterCaniterInted

    nfts =isOwnList? NftDataStore.myNftData: NftDataStore.nftData;

    _qureyNfts();
  }

  @override
  Widget constructView(BuildContext context) {
    // TODO: implement constructView
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Expanded(
          child: ListView.separated(
              itemBuilder: (context, position) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          SlideRightRoute(
                              page: NftPage(
                            principal:
                                nfts![position].nftData!.principal!.toString(),
                            nftData: nfts![position].nftData,
                            order: nfts![position].order,
                          )));
                    },
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          thumbnails.length == 0
                              ? Container(
                                  width: 82,
                                  height: 110,
                                )
                              : Image.file(
                                  thumbnails![position],
                                  width: 82,
                                  height: 110,
                                  fit: BoxFit.fitWidth,
                                ),
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            S.of(context).title,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            nfts![position].nftData!.title,
                                            style: TextStyle(),
                                          ),
                                        ],
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                      ),
                                    ),
                                    Text(
                                      nfts![position].order == null
                                          ? S.of(context).not_sell
                                          : ICPAccountUtils
                                                      .fromICPBigInt2Amount(
                                                          nfts![position]
                                                              .order!
                                                              .price!)
                                                  .toString() +
                                              " ICP",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: nfts![position].order == null
                                              ? Colors.grey
                                              : Colors.black87),
                                    )
                                  ],
                                ),
                                Text(
                                  S.of(context).owner_id,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  nfts![position].nftData!.owner.toString(),
                                  maxLines: 2,
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
              itemCount: nfts == null ? 0 : nfts!.length),
        ));
  }

  @override
  void hanldEvent(Event event) {
    // TODO: implement hanldEvent

    if (event is TransferNftEvent ||
        event is MintNftEvent ||
        event is BurnNftEvent) {
      _qureyNfts();
    }
  }

  _qureyNfts() async {
    SmartDialog.showLoading();
    List<NftDataWithOrder>? list = isOwnList
        ? await walletCanister!.balanceOf()
        : await walletCanister!.qureyNfts(page);
    SmartDialog.dismiss();

    thumbnails.clear();
    await Future.forEach(nfts!, (NftDataWithOrder item) async {
      File image = await FileUtil.writeBytestoFile(
          item.nftData!.principal.toString() + "-thumbnail",
          item.nftData!.mediaType,
          item.nftData!.thumbnail!);
      thumbnails!.add(image);
    });

    setState(() {});
  }




}
