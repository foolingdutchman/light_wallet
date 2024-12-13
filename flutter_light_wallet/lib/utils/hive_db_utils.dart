import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/model/token.dart';

import 'package:hive_flutter/hive_flutter.dart';


class HiveDBUtils {
  static Box? box;
  static const String BOX_NAME = 'wallet';
  static const String DB_NAME = 'hive_db';

  static Future<void> initHive() async {
    await Hive.initFlutter(DB_NAME);
    Hive.registerAdapter(WalletAdapter());
    Hive.registerAdapter(TokenAdapter());
    await Hive.openBox(BOX_NAME);
    box = Hive.box(BOX_NAME);
  }

  static bool isBoxOpen() {
    return box?.isOpen ?? false;
  }

  static bool isBoxEmpty() {
    return box?.isEmpty ?? true;
  }

  static int getWalletCounts() {
    return box?.length ?? 0;
  }

  static Wallet getCurrentWallet() {
    return box?.getAt(0);
  }

  static Wallet getWalletAtPosition(int position) {
    return box?.getAt(position);
  }

  static void addWallet(Wallet wallet) {
    box?.add(wallet);
  }

  static void switchWalletAsCurrent(Wallet wallet) {
    box?.delete(wallet);
    box?.putAt(0, wallet);
  }

  static List<Wallet> getWalletList() {
    List<Wallet> list = [];
    for (var i = 0; i < getWalletCounts(); i++) {
      list.add(getWalletAtPosition(i));
    }
    return list;
  }

  static void closeBox() {
    box?.close();
  }
}
