import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';

class LocalAuthUtil {
  static LocalAuthUtil? _instance;
  LocalAuthentication? _auth;

  LocalAuthUtil._() {
    _auth = LocalAuthentication();
  }

  factory LocalAuthUtil() => _instance ??= LocalAuthUtil._();

  // 检查设备
  Future<bool> checkBiometrics() async {
    return _auth!.canCheckBiometrics;
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await _auth!.getAvailableBiometrics();
      for (int i = 0; i < availableBiometrics.length; i++) {
        print('availableBiometric is : ' + availableBiometrics[i].toString());
      }
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      rethrow;
    }
    return availableBiometrics;
  }

  Future<bool> isSupportFingerprintAuth() async {
    bool isSuppport = false;
    List<BiometricType> available = await getAvailableBiometrics();
    if (available.length != 0) {
      for (int i = 0; i < available.length; i++) {
        if (available[i] == BiometricType.fingerprint) isSuppport = true;
      }
    }
    return isSuppport;
  }

  Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await _auth!.authenticate(
        localizedReason: S.current.os_determine_auth,
        options: AuthenticationOptions(stickyAuth: true),
      );
    } on PlatformException catch (e) {
      rethrow;
    }

    return authenticated;
  }
}
