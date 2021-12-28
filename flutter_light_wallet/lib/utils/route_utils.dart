

import 'package:flutter/material.dart';

class RouteHistory with ChangeNotifier {
  final List<Route> history = [];

  void add(Route<dynamic> route) {
    history.add(route);
    notifyListeners();
  }

  void remove(Route<dynamic> route) {
    history.remove(route);
    notifyListeners();
  }

  Route? filter(bool Function(Route) isMatch) {
    return history.firstWhere((element) => isMatch(element));
  }

  bool isActive(String? routeSettingName) {
    assert(routeSettingName != null);
    return filter((route) => route.settings.name == routeSettingName)
        ?.isActive ??
        false;
  }

  bool hasRoute(RoutePredicate predicate) {
    return history.any((e) => predicate(e));
  }

  bool hasActiveRoute(RoutePredicate predicate) {
    return history.any((e) => predicate(e) && e.isActive);

  }
  void removeRoute<T>(RoutePredicate predicate, [ T? result]) {
    // 需要新创建一个列表，否则会报错 ConcurrentModifyException
    List.of(history.where((e) => predicate(e))).forEach((route) {
      // 在移除route前手动调用此方法去完成Future
      route.didPop(result);
      // UI上的移除
      route.navigator!.removeRoute(route);
    });
  }

  void popUntil(RoutePredicate predicate, {dynamic Function(Route)? popResult}) {
    while (history.isNotEmpty && !predicate(history.last)) {
      history.last.navigator!.pop(popResult?.call(history.last));
    }
  }

  void checkDispose() {
    List.of(history.where((element) => !element.isActive)).forEach((element) {
      history.remove(element);
    });
  }

}

class RouteRecorder extends NavigatorObserver {
  final RouteHistory history;

  RouteRecorder(this.history);

  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    history.add(route!);
  }

  @override
  void didStopUserGesture() {
    // iOS：停止拖拽
  }

  @override
  void didStartUserGesture(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    // iOS：开始拖拽，如果达到距离则会出发didPop
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    history.remove(oldRoute!);
    history.add(newRoute!);
  }

  @override
  void didRemove(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    history.remove(route!);
  }

  @override
  void didPop(Route<dynamic>?route, Route<dynamic>? previousRoute) {
    history.remove(route!);
  }
}