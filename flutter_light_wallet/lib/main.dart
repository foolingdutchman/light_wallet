import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/color_util.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'generated/l10n.dart';
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
      localizationsDelegates: [
        S.delegate, //intl的delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'LWallet',
      // 设置语言
      supportedLocales: S.delegate.supportedLocales, //支持的国际化语言
     // locale: Locale('en', ''), //当前的语言
      localeListResolutionCallback: (locales, supportedLocales) {
        print('当前系统语言环境$locales');
        return;
      },
      theme: ThemeData(
       primarySwatch: ColorUtil.createMaterialColor(Color(0xff27a1e4)),
        
      ),
      home: HomePage(title: 'LWallet'),
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
