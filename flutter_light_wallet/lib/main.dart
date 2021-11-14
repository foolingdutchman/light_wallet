
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'view/home_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LWallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Light Wallet'),
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (InstanceStore.isStoreInit) {
      InstanceStore.updateDBandClose();
    }
    super.dispose();
  }
}
