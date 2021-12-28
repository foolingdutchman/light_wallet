import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/view/home_page.dart';
import 'package:flutter_light_wallet/view/nft/workroom_page.dart';
import 'package:flutter_light_wallet/view/wallet_page.dart';

import 'me_page.dart';
import 'record_page.dart';
import 'transfer_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AppPageState createState() => _AppPageState('app-page-detector');
}

class _AppPageState extends BasePageState<AppPage> {
  final pages = [WalletPage(), WorkRoomPage(), RecordPage(), MePage()];
  final titles = [
    S.current.wallet,
    S.current.work_room,
    S.current.record,
    S.current.mine
  ];
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(

        backgroundColor: Colors.blue,
        icon: Icon(Icons.wallet_membership),
        label: S.current.wallet),
    BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.store),
        label: S.current.work_room),
    BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.history),
        label: S.current.record),
    BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.person),
        label: S.current.mine),
  ];
  int currentIndex = 0;

  _AppPageState(String observerKey) : super(observerKey);

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void _changePage(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget constructView(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _changePage(index);
        },
      ),
      body: pages[currentIndex],
    );
  }

  @override
  void hanldEvent(Event event) {
    if (event is ClearWalletEvent) {
      Navigator.pushReplacement(
          context, SlideRightRoute(page: HomePage(title: 'LWallet')));
    }
  }

  @override
  void onFirstVisible() {}

  @override
  void onVisible() {}
}
