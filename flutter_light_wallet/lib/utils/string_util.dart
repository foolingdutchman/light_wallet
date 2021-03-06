import 'package:flutter/services.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:intl/intl.dart';

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
    showToast(S.current.has_copy_to_clipboard);
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

  static String getNumberFormatStr(dynamic number) {
    var f = NumberFormat("#,###", "en_US");
    return f.format(number);
  }


  
}
