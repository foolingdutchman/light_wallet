import 'dart:io';
import 'package:agent_dart/protobuf/ic_ledger/pb/v1/types.pb.dart';
import 'package:extended_image/extended_image.dart';
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
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
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
  String hintText=S.current.loading_data;

  _NftDataListViewState(String observerKey, this.isOwnList)
      : super(observerKey);

  @override
  void afterCaniterInted() {
    // TODO: implement afterCaniterInted
    nfts = isOwnList ? NftDataStore.myNftData : NftDataStore.nftData;
    _qureyNfts();
  }

  @override
  Widget constructView(BuildContext context) {
    // TODO: implement constructView
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
                    itemBuilder: (context, position) => position == nfts!.length?

                    InkWell(
                      onTap: () {
                        if(NftDataStore.isAllNftFetched){
                          setState(() {
                            hintText =S.of(context).no_more_data;
                          });
                        }else{
                          _attachData();
                        }
                      },
                      child: Container( height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text("$hintText"),
                        ),
                      ))
                        :InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                SlideRightRoute(
                                    page: NftPage(
                                  principal: nfts![position]
                                      .nftData!
                                      .principal!
                                      .toString(),
                                  nftData: nfts![position].nftData,
                                  order: nfts![position].order,
                                )));
                          },
                          child: Container(
                            height: 140,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                thumbnails.length != 0 &&
                                        position < thumbnails.length
                                    ?
                                Image.file(
                                        thumbnails[position],
                                        width: 82,
                                        height: 110,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        width: 82,
                                        height: 110,
                                      ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15.0,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  nfts![position]
                                                      .nftData!
                                                      .title,
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
                                                color: nfts![position].order ==
                                                        null
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
                                        nfts![position]
                                            .nftData!
                                            .owner
                                            .toString(),
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
                    itemCount: nfts == null ? 0 : isOwnList? nfts!.length: nfts!.length+1),
              ),
            ),
          ),
        ));
  }

  @override
  void hanldEvent(Event event) {
    // TODO: implement hanldEvent
    if (event is NftDataStoreUpdateEvent) {
      nfts = isOwnList ? NftDataStore.myNftData : NftDataStore.nftData;
      _updateImages();
    }
  }

  Future<void> _updateImages() async {
    thumbnails.clear();
    await Future.forEach(nfts!, (NftDataWithOrder item) async {
      File image = await FileUtil.writeBytestoFile(
          item.nftData!.principal.toString() + "-thumbnail",
          item.nftData!.mediaType,
          item.nftData!.thumbnail!);
      thumbnails.add(image);
    });

    setState(() {});
  }

  _qureyNfts() async {
    if (!isOwnList) {
      if (!NftDataStore.isNftDataFresh) {
        SmartDialog.showLoading();
        await NftDataStore.fetchNftData();
        SmartDialog.dismiss();
      }
    } else {
      if (!NftDataStore.isMyNftDatafresh) {
        SmartDialog.showLoading();
        await NftDataStore.fetchMyNftData();
        SmartDialog.dismiss();
      }
    }
    await _updateImages();
    setState(() {
      nfts = isOwnList ? NftDataStore.myNftData : NftDataStore.nftData;
      hintText = S.current.click_to_load_more;
    });
  }

  Future<void> _refreshData() async {
    if (!isOwnList) {
      SmartDialog.showLoading();
      await NftDataStore.fetchNftData();
      SmartDialog.dismiss();
    } else {
      SmartDialog.showLoading();
      await NftDataStore.fetchMyNftData();
      SmartDialog.dismiss();
    }
    await _updateImages();
    setState(() {
      nfts = isOwnList ? NftDataStore.myNftData : NftDataStore.nftData;
      hintText = S.current.click_to_load_more;
    });
  }

  void _attachData() async{
    SmartDialog.showLoading();
    await NftDataStore.fetchAttachedNftData();
    SmartDialog.dismiss();
    await _updateImages();
    setState(() {
      nfts = isOwnList ? NftDataStore.myNftData : NftDataStore.nftData;
    });
  }
}
