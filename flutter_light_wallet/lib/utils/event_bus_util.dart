import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter_light_wallet/model/wallet.dart';

class EventBusUtil {
  static EventBus? _eventBus;

  //获取单例
  static EventBus? getInstance() {
    if (_eventBus == null) {
      _eventBus = EventBus();
    }
    return _eventBus;
  }

  //返回某事件的订阅者
  static StreamSubscription<T> listen<T extends Event>(
      Function(T event) onData) {
    if (_eventBus == null) {
      _eventBus = EventBus();
    }
    //内部流属于广播模式，可以有多个订阅者
    return _eventBus!.on<T>().listen(onData);
  }

  //发送事件
  static void fire<T extends Event>(T e) {
    if (_eventBus == null) {
      _eventBus = EventBus();
    }
    _eventBus!.fire(e);
  }
}

abstract class Event {}

class NewWalletEvent extends Event {
  Wallet wallet;
  NewWalletEvent(this.wallet);
}

class DeleteWalletEvent extends Event {
  Wallet wallet;
  DeleteWalletEvent(this.wallet);
}

class SwitchWalletEvent extends Event {
  Wallet wallet;
  SwitchWalletEvent(this.wallet);
}

class TransactionEvent extends Event {
  TransactionEvent();
}

class ClearWalletEvent extends Event {
  
}

class MintNftEvent extends Event{}

class TransferNftEvent extends Event{}

class BurnNftEvent extends Event{}
