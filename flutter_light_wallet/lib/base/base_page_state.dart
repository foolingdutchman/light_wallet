import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:visibility_detector/visibility_detector.dart';

abstract class BasePageState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  BasePageState(this.observerKey);
  String observerKey;
  bool isFirstVisible = true;
  StreamSubscription<Event>? _subscription;

  DateTime? _lastPressedAt;
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON PRESSED!"); // Do some stuff.
    String infostr = info.currentRoute(context)!.isFirst.toString();
    print("RouteInfo is : " + infostr);
    if (!info.currentRoute(context)!.isFirst) {
      return false;
    } else if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 5)) {
      //两次点击间隔超过1秒则重新计时
      _lastPressedAt = DateTime.now();
      StringUtil.showToast('再次返回退出应用');
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(observerKey),
      onVisibilityChanged: onPageVisibilityChanged,
      child: constructView(context),
    );
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    _subscription = EventBusUtil.listen((event) {
      print('event received!');
      hanldEvent(event);
    });
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    _subscription?.cancel();
    super.dispose();
  }

  Widget constructView(BuildContext context);

  void onPageVisibilityChanged(VisibilityInfo visibilityInfo) {
    if (visibilityInfo.visibleFraction == 1 && isFirstVisible) {
      print('Page first visible! ');
      onFirstVisible();
      setState(() {
        isFirstVisible = false;
      });
    } else if (visibilityInfo.visibleFraction == 1) {
      print('Page  visible! ');
      onVisible();
    }

    print('Page visible :' + visibilityInfo.visibleFraction.toString());
  }

  void onFirstVisible();

  void onVisible();
  void hanldEvent(Event event);
}
