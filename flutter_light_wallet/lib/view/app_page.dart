
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/view/wallet_page.dart';
import 'me_page.dart';
import 'record_page.dart';
import 'transfer_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final pages = [WalletPage(), TransferPage(), RecordPage(), MePage()];
  final titles = ['钱包', '转账', '记录', '我的'];
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.wallet_membership),
        label: '钱包'),
    BottomNavigationBarItem(
        backgroundColor: Colors.blue, icon: Icon(Icons.transform), label: '转账'),
    BottomNavigationBarItem(
        backgroundColor: Colors.blue, icon: Icon(Icons.history), label: '记录'),
    BottomNavigationBarItem(
        backgroundColor: Colors.blue, icon: Icon(Icons.person), label: '我的'),
  ];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
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

  void _changePage(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}
