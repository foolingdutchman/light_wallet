//import 'package:counter/utils/fingerprint_auth_util.txt';

import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/utils/rosetta_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hive_db_utils.dart';

class InstanceStore {
  static const String IS_LOCAL_AUTH_AVAILABLE = 'isLocalAuthAvailabel';
  static const String IS_GUESTURE_PASSWORD_INIT = 'isGuesturePasswordInit';
  static const String IS_FIGER_PRINT_PASSWORD_INIT = 'isFigerPrintPasswordInit';
  static const String IS_GUESTURE_PASSWORD_ACTIVE =
      'isFigerPrintPasswordActive';
  static const String IS_FIGER_PRINT_PASSWORD_ACTIVE =
      'isGuesturePrintPasswordActive';
  static List<Wallet> walletLists = [];
  static List<RosettaTransactionRecord> transactions = [];
  static Wallet? currentWallet;
  static bool isStoreInit = false;
  static bool isBlanceUpdated = false;
  static bool isRecordUpdated = false;
  static SharedPreferences? prefs;
  static DeviceInfo? deviceInfo;
  static Future<void> init() async {
    await HiveDBUtils.initHive();
    prefs = await SharedPreferences.getInstance();
    //  await FingerprintAuthUtil().getAvailableBiometrics();
    if (prefs?.getBool(IS_GUESTURE_PASSWORD_ACTIVE) == null) {
      print('empty prefs!');
      await saveDeviceInfo(new DeviceInfo());
    }
    deviceInfo = getDeviceInfoFromSharepref();
    if (HiveDBUtils.isBoxOpen() && !HiveDBUtils.isBoxEmpty()) {
      walletLists.addAll(HiveDBUtils.getWalletList());
      currentWallet = walletLists[0];
      print("wallet info: \n" +
          " wallet principal is " +
          currentWallet!.principal +
          '\n address is : ' +
          currentWallet!.address);

      //Navigator.pop(context);
    }

    isStoreInit = true;
  }

  static Future<void> updateHiveDB() async {
    HiveDBUtils.box?.clear();
    if (walletLists.length != 0) HiveDBUtils.box?.addAll(walletLists);
  }

  static void updateCurrentWallet() {
    walletLists.removeAt(0);
    walletLists.insert(0, currentWallet!);
    currentWallet = walletLists[0];
  }

  static void swithCurrentWallet(Wallet wallet) async {
    walletLists.remove(wallet);
    walletLists.insert(0, wallet);
    currentWallet = wallet;
    updateHiveDB();
  }

  static void updateDBandClose() async {
    updateHiveDB();
    HiveDBUtils.closeBox();
  }

  static Future<void> saveDeviceInfo(DeviceInfo deviceInfo) async {
    await prefs?.setBool(
        IS_FIGER_PRINT_PASSWORD_ACTIVE, deviceInfo.isFigerPrintPasswordActive);
    await prefs?.setBool(
        IS_FIGER_PRINT_PASSWORD_INIT, deviceInfo.isFigerPrintPasswordInit);
    await prefs?.setBool(
        IS_GUESTURE_PASSWORD_ACTIVE, deviceInfo.isGuesturePrintPasswordActive);
    await prefs?.setBool(
        IS_GUESTURE_PASSWORD_INIT, deviceInfo.isGuesturePasswordInit);
    await prefs?.setBool(
        IS_LOCAL_AUTH_AVAILABLE, deviceInfo.isLocalAuthAvailabel);
  }

  static Future<void> saveCurrentDeviceInfo() async {
    saveDeviceInfo(deviceInfo!);
  }

  static void removeWallet(Wallet wallet) {
    walletLists.remove(wallet);
    if (walletLists.length != 0) {
      currentWallet = walletLists[0];
    } else
      currentWallet = null;
    updateHiveDB();
  }

  static void needRefreshData() {
    isBlanceUpdated = false;
    isRecordUpdated = false;
  }

  static DeviceInfo getDeviceInfoFromSharepref() {
    DeviceInfo deviceInfo = DeviceInfo();
    deviceInfo.isFigerPrintPasswordActive =
        prefs?.getBool(IS_FIGER_PRINT_PASSWORD_ACTIVE) ?? false;
    deviceInfo.isFigerPrintPasswordInit =
        prefs?.getBool(IS_FIGER_PRINT_PASSWORD_INIT) ?? false;
    deviceInfo.isGuesturePasswordInit =
        prefs?.getBool(IS_GUESTURE_PASSWORD_INIT) ?? false;
    deviceInfo.isGuesturePrintPasswordActive =
        prefs?.getBool(IS_GUESTURE_PASSWORD_ACTIVE) ?? false;
    deviceInfo.isLocalAuthAvailabel =
        prefs?.getBool(IS_LOCAL_AUTH_AVAILABLE) ?? false;
    return deviceInfo;
  }

  static Future<bool> createWallet(Wallet wallet) async {
    if (!walletLists.any((element) => element.address == wallet.address)) {
      walletLists.add(wallet);
      currentWallet = walletLists[0];
      await updateHiveDB();
      return true;
    } else {
      print('wallet already existed!');
      return false;
    }
  }
}

class DeviceInfo {
  bool isLocalAuthAvailabel = false;
  bool isGuesturePasswordInit = false;
  bool isFigerPrintPasswordInit = false;
  bool isFigerPrintPasswordActive = false;
  bool isGuesturePrintPasswordActive = false;
}
