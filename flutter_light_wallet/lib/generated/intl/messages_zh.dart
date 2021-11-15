// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static String m0(left_time) => "密码错误, 你还剩 ${left_time} 次机会";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activate_fingerprint_password":
            MessageLookupByLibrary.simpleMessage("激活指纹密码"),
        "activate_guester_password":
            MessageLookupByLibrary.simpleMessage("激活手势密码"),
        "add_wallet": MessageLookupByLibrary.simpleMessage("添加钱包"),
        "address": MessageLookupByLibrary.simpleMessage("地址"),
        "amount": MessageLookupByLibrary.simpleMessage("数量"),
        "appName": MessageLookupByLibrary.simpleMessage("LWallet"),
        "assetList": MessageLookupByLibrary.simpleMessage("资产列表"),
        "back": MessageLookupByLibrary.simpleMessage("返回"),
        "balance": MessageLookupByLibrary.simpleMessage("余额"),
        "block_height": MessageLookupByLibrary.simpleMessage("区块高度"),
        "comfirm_mnemonic_backup":
            MessageLookupByLibrary.simpleMessage("确定助记词已备份"),
        "confirm": MessageLookupByLibrary.simpleMessage("确定"),
        "confirm_import_mnemonic":
            MessageLookupByLibrary.simpleMessage("确认导入助记词"),
        "confirm_mnemonic": MessageLookupByLibrary.simpleMessage("确认助记词"),
        "copy_mnemonic": MessageLookupByLibrary.simpleMessage("复制助记词"),
        "create_wallet": MessageLookupByLibrary.simpleMessage("创建钱包"),
        "current_address": MessageLookupByLibrary.simpleMessage("当前钱包地址"),
        "delete_wallet": MessageLookupByLibrary.simpleMessage("删除钱包"),
        "emport_mnemonic": MessageLookupByLibrary.simpleMessage("导出助记词"),
        "empty_password_hint": MessageLookupByLibrary.simpleMessage("密码不能为空"),
        "export_mnemonic": MessageLookupByLibrary.simpleMessage("导出助记词"),
        "fee": MessageLookupByLibrary.simpleMessage("转账费用"),
        "from": MessageLookupByLibrary.simpleMessage("从"),
        "guesture_password_settled":
            MessageLookupByLibrary.simpleMessage("手势密码已设置"),
        "has_copy_to_clipboard":
            MessageLookupByLibrary.simpleMessage("已复制到剪切板"),
        "import_mnemonic": MessageLookupByLibrary.simpleMessage("导入助记词"),
        "import_wallet": MessageLookupByLibrary.simpleMessage("导入钱包"),
        "input_guesture_password":
            MessageLookupByLibrary.simpleMessage("输入手势密码"),
        "input_mnemonic": MessageLookupByLibrary.simpleMessage("输入助记词"),
        "input_orignal_password":
            MessageLookupByLibrary.simpleMessage("输入原始密码"),
        "input_password": MessageLookupByLibrary.simpleMessage("输入密码"),
        "input_password_again": MessageLookupByLibrary.simpleMessage("再次输入密码"),
        "invalid_address_hint":
            MessageLookupByLibrary.simpleMessage("请输入有效ICP地址"),
        "invalid_amount_hint":
            MessageLookupByLibrary.simpleMessage("请输入有效ICP数量"),
        "manage": MessageLookupByLibrary.simpleMessage("管理"),
        "max_amount": MessageLookupByLibrary.simpleMessage("最大数量"),
        "mine": MessageLookupByLibrary.simpleMessage("我的"),
        "mnemonic_format_incorrect":
            MessageLookupByLibrary.simpleMessage("助记词格式不正确"),
        "modify_guesture_password":
            MessageLookupByLibrary.simpleMessage("修改手势密码"),
        "modify_password": MessageLookupByLibrary.simpleMessage("修改密码"),
        "new_guesture_password":
            MessageLookupByLibrary.simpleMessage("输入新手势密码"),
        "no_more_data": MessageLookupByLibrary.simpleMessage("没有更多数据了"),
        "password_input_hint": MessageLookupByLibrary.simpleMessage("请输入密码"),
        "password_insist_hint": MessageLookupByLibrary.simpleMessage("密码输入不一致"),
        "password_modified_hint": MessageLookupByLibrary.simpleMessage("密码已修改"),
        "password_verified": MessageLookupByLibrary.simpleMessage("密码已验证!"),
        "password_wrong_hint": MessageLookupByLibrary.simpleMessage("密码错误"),
        "pricinpal_id": MessageLookupByLibrary.simpleMessage("Pricinpal ID"),
        "receipt_address": MessageLookupByLibrary.simpleMessage("收款地址"),
        "record": MessageLookupByLibrary.simpleMessage("记录"),
        "repeat_guesture_password":
            MessageLookupByLibrary.simpleMessage("再次输入手势密码"),
        "save_mnemonic": MessageLookupByLibrary.simpleMessage("保存助记词"),
        "select_as_default_wallet":
            MessageLookupByLibrary.simpleMessage("设置为默认钱包"),
        "select_default_wallet_hint":
            MessageLookupByLibrary.simpleMessage("已设置为默认钱包"),
        "select_mnemonic_words": MessageLookupByLibrary.simpleMessage("选择助记词"),
        "set_guesture_password": MessageLookupByLibrary.simpleMessage("设置手势密码"),
        "settings": MessageLookupByLibrary.simpleMessage("设置"),
        "to": MessageLookupByLibrary.simpleMessage("至"),
        "transaction_record": MessageLookupByLibrary.simpleMessage("转账记录"),
        "transfer": MessageLookupByLibrary.simpleMessage("转账"),
        "transfer_amount": MessageLookupByLibrary.simpleMessage("转账数量"),
        "transfer_success": MessageLookupByLibrary.simpleMessage("转账成功!"),
        "version": MessageLookupByLibrary.simpleMessage("版本"),
        "wallet": MessageLookupByLibrary.simpleMessage("钱包"),
        "wallet_created_hint": MessageLookupByLibrary.simpleMessage("钱包已创建"),
        "wallet_exists_hint": MessageLookupByLibrary.simpleMessage("钱包已存在"),
        "wallet_manage": MessageLookupByLibrary.simpleMessage("钱包管理"),
        "wrong_guesture_password_hint": m0,
        "wrong_mnemonic_words_sequences":
            MessageLookupByLibrary.simpleMessage("助记词顺序错误")
      };
}
