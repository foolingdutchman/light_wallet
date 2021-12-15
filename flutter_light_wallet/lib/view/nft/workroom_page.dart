import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_nft_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/file_util.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';
import 'package:flutter_light_wallet/view/nft/nft_creator_page.dart';
import 'package:flutter_light_wallet/view/nft/nft_page.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';


class WorkRoomPage extends StatefulWidget {
  const WorkRoomPage({Key? key}) : super(key: key);

  @override
  _WorkRoomPageState createState() =>
      _WorkRoomPageState("work-room-page-detector");
}

class _WorkRoomPageState extends BaseNftPageState<WorkRoomPage> {
  _WorkRoomPageState(String observerKey) : super(observerKey);
  int page = 1;
  List<NftData>? nfts;
  List<File> thumbnails = [];

  @override
  Widget constructView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 80, left: 30, right: 30),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                S.of(context).work_room,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, SlideRightRoute(page: NftCreatorPage()));
                // _prePareMintNft(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12, width: 0.5),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(5, 5),
                          blurRadius: 10,
                          color: Colors.black12),
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Make Your Own NFT Art",
                        style: TextStyle(
                            color: Color(0xffe4542a),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(child: Container()),
                        Icon(
                          Icons.precision_manufacturing,
                          size: 80,
                          color: Color(0xfff3ab39),
                        ),
                        Icon(
                          Icons.science,
                          size: 50,
                          color: Color(0xff39267e),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                    Container(
                      height: 10,
                      width: MediaQuery.of(context).size.width - 150,
                      color: Color(0xffe91f6f),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, position) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              SlideRightRoute(
                                  page: NftPage(
                                principal:
                                    "",nftData: nfts![position],
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
                                    Text(
                                      "Title",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(nfts![position].title),
                                    Text(
                                      "Owner Id",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(nfts![position].owner.toString()),
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
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    AssetPicker.registerObserve();
  }

  @override
  void dispose() {
    super.dispose();
    AssetPicker.unregisterObserve(); // Unregister callback.
  }

  @override
  void hanldEvent(Event event) {
    // TODO: implement hanldEvent
  }

  @override
  void afterCaniterInted() {

    walletCanister!.getContractInfo();
   // _qureyNfts();
  }

  _qureyNfts() async {
    SmartDialog.showLoading();
    nfts = await walletCanister!.qureyNfts(page);
    thumbnails.clear();
    await Future.forEach(nfts!, (NftData item) async {
      File image = await FileUtil.writeBytestoFile(
          item.principal.toString() + "-thumbnail",
          item!.mediaType,
          item!.thumbnail!);
      thumbnails!.add(image);
    });

    setState(() {});
    SmartDialog.dismiss();
  }


   Widget createListView(List<NftData>? nftDatas){
    return Expanded(
       child: ListView.separated(
           itemBuilder: (context, position) => InkWell(
             onTap: () {
               Navigator.push(
                   context,
                   SlideRightRoute(
                       page: NftPage(
                         principal:
                         "",nftData: nftDatas![position],
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
                             Text(
                               "Title",
                               style: TextStyle(
                                   fontSize: 14,
                                   fontWeight: FontWeight.bold),
                             ),
                             Text(nfts![position].title),
                             Text(
                               "Owner Id",
                               style: TextStyle(
                                   fontSize: 14,
                                   fontWeight: FontWeight.bold),
                             ),
                             Text(nfts![position].owner.toString()),
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
     );

  }
}
