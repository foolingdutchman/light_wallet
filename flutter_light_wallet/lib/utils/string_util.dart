import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class StringUtil {
  static String longTimeStampToDateString(int timestasmp) {
    return DateTime.fromMicrosecondsSinceEpoch((timestasmp / 1000).round())
        .toLocal()
        .toString()
        .substring(0, 16);
  }

  static void copyTexttoClipboard(String text) {
    print(" copy clicked!");
    Clipboard.setData(ClipboardData(text: text));
    showToast("已复制到剪切板");
  }

  static showToast(String content) {
    SmartDialog.showToast(content);
  }

  static bool isICPAddress(String string) {
    RegExp icpAddress =
        new RegExp(r"(?![0-9]+$)(?![a-fA-F]+$)[0-9A-Fa-f]{64,64}$");
    return icpAddress.hasMatch(string);
  }

  static List<int> getIntListFromString(String str) {
    print(' int list string is ' + str);
    List<String> list = str.split(',');
    List<int> intList = [];
    for (var i = 0; i < list.length; i++) {
      intList.add(int.parse(list[i]));
    }
    return intList;
  }
}
