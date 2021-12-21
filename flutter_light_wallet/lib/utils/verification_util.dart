import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';
import 'package:flutter_light_wallet/view/%08password_page.dart';

import 'package:flutter_light_wallet/view/guesture_password.dart';

import 'Instance_store.dart';
import 'local_auth_util.dart';

class VerificationUtils {
  static Future<String> verifyProcess(BuildContext context) async {
    String result = '';
    if (InstanceStore.deviceInfo!.isFigerPrintPasswordActive) {
      result = await verifyFingerprintPassword();
    } else if (InstanceStore.deviceInfo!.isGuesturePrintPasswordActive &&
        InstanceStore.currentWallet!.guesturePassword != '') {
      result = await verifyGesturePassword(context);
    } else {
      result = await verifyPassword(context);
    }
    return result;
  }

  static Future<String> verifyFingerprintPassword() async {
    bool _isAuth = false;
    if (InstanceStore.deviceInfo!.isFigerPrintPasswordActive) {
      _isAuth = await LocalAuthUtil().authenticate();
    }
    StringUtil.showToast(_isAuth ? "Auth success!" : " Auth failed!");

    return _isAuth ? "OK" : "";
  }

  static Future<String> verifyGesturePassword(BuildContext context) async {
    String result = await Navigator.push(
        context,
        SlideRightRoute(
            page: GuesturePasswordPage(
          type: 'verify_password',
          wallet: InstanceStore.currentWallet,
        )));
    return result;
  }

  static Future<String> verifyPassword(BuildContext context) async {
    String result = await Navigator.push(
        context, SlideRightRoute(page: PasswordPage(type: 'verify_password')));
    return result;
  }

  static VerifyType getVerifyType() {
    if (InstanceStore.deviceInfo!.isFigerPrintPasswordActive) {
      return VerifyType.LOCAL_AUTH;
    } else if (InstanceStore.deviceInfo!.isGuesturePrintPasswordActive &&
        InstanceStore.currentWallet!.guesturePassword != '') {
      return VerifyType.GESTURE_PASSWORD;
    } else {
      return VerifyType.PASWORD;
    }
  }
}

enum VerifyType { LOCAL_AUTH, GESTURE_PASSWORD, PASWORD }
