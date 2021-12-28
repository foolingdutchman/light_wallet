import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_nft_page_state.dart';
import 'package:flutter_light_wallet/base/base_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/file_util.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';
import 'package:flutter_light_wallet/view/nft/invoice_list_view.dart';
import 'package:flutter_light_wallet/view/nft/nft_creator_page.dart';
import 'package:flutter_light_wallet/view/nft/nft_page.dart';
import 'package:flutter_light_wallet/view/nft/transfer_record_view.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'nft_list_view.dart';


class WorkRoomPage extends StatefulWidget {
  const WorkRoomPage({Key? key}) : super(key: key);

  @override
  _WorkRoomPageState createState() =>
      _WorkRoomPageState("work-room-page-detector");
}

class _WorkRoomPageState extends BasePageState<WorkRoomPage> with TickerProviderStateMixin{

  _WorkRoomPageState(String observerKey) : super(observerKey);

  TabController? _tabController ;
  PageController? _pageController ;
   static final List<String> _titleList =[S.current.nft,S.current.my_nft,S.current.my_invoice,S.current.my_transactions];
   List<Widget> pages = [NftDataListView(isOwnList: false,),NftDataListView(isOwnList: true,),InvoiceListView(),TransferRecordView()];
  @override
   initState(){
     super.initState();
     _tabController = TabController(length: _titleList.length, vsync: this);
     _pageController = PageController();
   }
  @override
   dispose(){
    _tabController!.dispose();
    _pageController!.dispose();
    super.dispose();
   }

  void _changeTab(int index) {
    _pageController!.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _onPageChanged(int index) {
    _tabController!.animateTo(index, duration: Duration(milliseconds: 300));
  }

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
                        S.of(context).make_your_nft,
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              margin: EdgeInsets.only(top: 10,bottom: 10),
              child: TabBar(
                labelColor: Colors.black87,//选中的颜色
                labelStyle: TextStyle(color: Colors.black87, fontSize: 15 ,fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.black54,//未选中的颜色
                unselectedLabelStyle: TextStyle(color: Colors.black54, fontSize: 15),
                isScrollable: true,
                //自定义indicator样式
                indicator: BoxDecoration(
                    color: Color(0x11000000),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                controller: _tabController,
                onTap: _changeTab,
                tabs: _titleList.map((e) => Tab(text: e)).toList(),
              ),
            ),
            Expanded(
                child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: _titleList.length,
                    itemBuilder: (context, index) {
                      return pages[index];
                    }
                )
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



  @override
  void onFirstVisible() {
    // TODO: implement onFirstVisible
  }

  @override
  void onVisible() {
    // TODO: implement onVisible
  }




}
