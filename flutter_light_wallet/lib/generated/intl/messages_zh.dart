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
        "activate_local_auth": MessageLookupByLibrary.simpleMessage("激活生物验证"),
        "add_wallet": MessageLookupByLibrary.simpleMessage("添加钱包"),
        "address": MessageLookupByLibrary.simpleMessage("地址"),
        "amount": MessageLookupByLibrary.simpleMessage("数量"),
        "appName": MessageLookupByLibrary.simpleMessage("LWallet"),
        "assetList": MessageLookupByLibrary.simpleMessage("资产列表"),
        "author": MessageLookupByLibrary.simpleMessage("作者"),
        "back": MessageLookupByLibrary.simpleMessage("返回"),
        "balance": MessageLookupByLibrary.simpleMessage("余额"),
        "block_height": MessageLookupByLibrary.simpleMessage("区块高度"),
        "burn": MessageLookupByLibrary.simpleMessage("销毁"),
        "buy": MessageLookupByLibrary.simpleMessage("购买"),
        "cancel_sell": MessageLookupByLibrary.simpleMessage("取消出售"),
        "change_price": MessageLookupByLibrary.simpleMessage("更改价格"),
        "click_to_load_more": MessageLookupByLibrary.simpleMessage("点击加载更多..."),
        "collect": MessageLookupByLibrary.simpleMessage("收款"),
        "comfirm_mnemonic_backup":
            MessageLookupByLibrary.simpleMessage("确定助记词已备份"),
        "confirm": MessageLookupByLibrary.simpleMessage("确定"),
        "confirm_import_mnemonic":
            MessageLookupByLibrary.simpleMessage("确认导入助记词"),
        "confirm_mnemonic": MessageLookupByLibrary.simpleMessage("确认助记词"),
        "copy_mnemonic": MessageLookupByLibrary.simpleMessage("复制助记词"),
        "copyright_declearation": MessageLookupByLibrary.simpleMessage(
            "请确保你创作的NFT作品内容为原创作品，由此作品产生的任何版权相关纠纷均与平台无关。"),
        "counter_address": MessageLookupByLibrary.simpleMessage("收银台地址"),
        "create_wallet": MessageLookupByLibrary.simpleMessage("创建钱包"),
        "creator_id": MessageLookupByLibrary.simpleMessage("创作人 Principal"),
        "creator_principal":
            MessageLookupByLibrary.simpleMessage("创作人 Principal"),
        "current_address": MessageLookupByLibrary.simpleMessage("当前钱包地址"),
        "current_remaining_canister_space":
            MessageLookupByLibrary.simpleMessage("当前容器剩余空间"),
        "data_not_ready": MessageLookupByLibrary.simpleMessage("数据未准备好..."),
        "delete_wallet": MessageLookupByLibrary.simpleMessage("删除钱包"),
        "desc": MessageLookupByLibrary.simpleMessage("描述"),
        "emport_mnemonic": MessageLookupByLibrary.simpleMessage("导出助记词"),
        "empty_password_hint": MessageLookupByLibrary.simpleMessage("密码不能为空"),
        "export_mnemonic": MessageLookupByLibrary.simpleMessage("导出助记词"),
        "fee": MessageLookupByLibrary.simpleMessage("转账费用"),
        "fingerprint_auth": MessageLookupByLibrary.simpleMessage("指纹识别"),
        "from": MessageLookupByLibrary.simpleMessage("从"),
        "guesture_password_settled":
            MessageLookupByLibrary.simpleMessage("手势密码已设置"),
        "has_copy_to_clipboard":
            MessageLookupByLibrary.simpleMessage("已复制到剪切板"),
        "hint_burn_token":
            MessageLookupByLibrary.simpleMessage("Token永久销毁不可找回!"),
        "hint_icp_not_enough":
            MessageLookupByLibrary.simpleMessage("你的ICP余额不足!"),
        "hint_save_code_failded": MessageLookupByLibrary.simpleMessage("保存失败"),
        "hint_save_code_success":
            MessageLookupByLibrary.simpleMessage("二维码已保存至相册"),
        "hint_unsupport_local_auth":
            MessageLookupByLibrary.simpleMessage("你的手机不支持生物验证"),
        "import_mnemonic": MessageLookupByLibrary.simpleMessage("导入助记词"),
        "import_wallet": MessageLookupByLibrary.simpleMessage("导入钱包"),
        "important_notice": MessageLookupByLibrary.simpleMessage("重要提示"),
        "input_author": MessageLookupByLibrary.simpleMessage("输入作者"),
        "input_desc": MessageLookupByLibrary.simpleMessage("输入描述"),
        "input_guesture_password":
            MessageLookupByLibrary.simpleMessage("输入手势密码"),
        "input_mnemonic": MessageLookupByLibrary.simpleMessage("输入助记词"),
        "input_orignal_password":
            MessageLookupByLibrary.simpleMessage("输入原始密码"),
        "input_password": MessageLookupByLibrary.simpleMessage("输入密码"),
        "input_password_again": MessageLookupByLibrary.simpleMessage("再次输入密码"),
        "input_title": MessageLookupByLibrary.simpleMessage("输入标题"),
        "invalid_address_hint":
            MessageLookupByLibrary.simpleMessage("请输入有效ICP地址"),
        "invalid_amount_hint":
            MessageLookupByLibrary.simpleMessage("请输入有效ICP数量"),
        "invalid_principal":
            MessageLookupByLibrary.simpleMessage("无效principal..."),
        "invoice": MessageLookupByLibrary.simpleMessage("发票"),
        "invoice_no": MessageLookupByLibrary.simpleMessage("发票号"),
        "invoice_type": MessageLookupByLibrary.simpleMessage("发票类型"),
        "issue_date": MessageLookupByLibrary.simpleMessage("生成日期"),
        "loading_data": MessageLookupByLibrary.simpleMessage("数据正在加载..."),
        "local_auth": MessageLookupByLibrary.simpleMessage("生物验证"),
        "make_nft": MessageLookupByLibrary.simpleMessage("制作NFT"),
        "make_your_nft": MessageLookupByLibrary.simpleMessage("制作你自己的NFT作品！"),
        "manage": MessageLookupByLibrary.simpleMessage("管理"),
        "max_amount": MessageLookupByLibrary.simpleMessage("最大数量"),
        "mine": MessageLookupByLibrary.simpleMessage("我的"),
        "mint": MessageLookupByLibrary.simpleMessage("铸造"),
        "mint_cost": MessageLookupByLibrary.simpleMessage("铸造费用"),
        "mnemonic_format_incorrect":
            MessageLookupByLibrary.simpleMessage("助记词格式不正确"),
        "modify_guesture_password":
            MessageLookupByLibrary.simpleMessage("修改手势密码"),
        "modify_password": MessageLookupByLibrary.simpleMessage("修改密码"),
        "my_invoice": MessageLookupByLibrary.simpleMessage("我的发票"),
        "my_nft": MessageLookupByLibrary.simpleMessage("我的Nft"),
        "my_transactions": MessageLookupByLibrary.simpleMessage("我的转账"),
        "new_guesture_password":
            MessageLookupByLibrary.simpleMessage("输入新手势密码"),
        "nft": MessageLookupByLibrary.simpleMessage("NFT"),
        "nft_detail": MessageLookupByLibrary.simpleMessage("NFT展示"),
        "no_more_data": MessageLookupByLibrary.simpleMessage("没有更多数据了"),
        "not_sell": MessageLookupByLibrary.simpleMessage("未出售"),
        "os_determine_auth":
            MessageLookupByLibrary.simpleMessage("让设备系统选择识别方式"),
        "owner_id": MessageLookupByLibrary.simpleMessage("持有人 Principal"),
        "password_input_hint": MessageLookupByLibrary.simpleMessage("请输入密码"),
        "password_insist_hint": MessageLookupByLibrary.simpleMessage("密码输入不一致"),
        "password_modified_hint": MessageLookupByLibrary.simpleMessage("密码已修改"),
        "password_verified": MessageLookupByLibrary.simpleMessage("密码已验证!"),
        "password_wrong_hint": MessageLookupByLibrary.simpleMessage("密码错误"),
        "pay_the_bill": MessageLookupByLibrary.simpleMessage("支付账单"),
        "price": MessageLookupByLibrary.simpleMessage("价格"),
        "pricinpal_id": MessageLookupByLibrary.simpleMessage("Pricinpal ID"),
        "purchase": MessageLookupByLibrary.simpleMessage("购买"),
        "purchase_price": MessageLookupByLibrary.simpleMessage("购买价格"),
        "receipt_address": MessageLookupByLibrary.simpleMessage("收款地址"),
        "receipt_principal":
            MessageLookupByLibrary.simpleMessage("收款人Principal"),
        "record": MessageLookupByLibrary.simpleMessage("记录"),
        "repeat_guesture_password":
            MessageLookupByLibrary.simpleMessage("再次输入手势密码"),
        "save_2d_code": MessageLookupByLibrary.simpleMessage("保存二维码"),
        "save_mnemonic": MessageLookupByLibrary.simpleMessage("保存助记词"),
        "select_as_default_wallet":
            MessageLookupByLibrary.simpleMessage("设置为默认钱包"),
        "select_default_wallet_hint":
            MessageLookupByLibrary.simpleMessage("已设置为默认钱包"),
        "select_mnemonic_words": MessageLookupByLibrary.simpleMessage("选择助记词"),
        "select_your_art": MessageLookupByLibrary.simpleMessage("选择你的作品！"),
        "sell": MessageLookupByLibrary.simpleMessage("出售"),
        "seller_address": MessageLookupByLibrary.simpleMessage("卖家地址"),
        "set_guesture_password": MessageLookupByLibrary.simpleMessage("设置手势密码"),
        "set_price": MessageLookupByLibrary.simpleMessage("设置价格"),
        "settings": MessageLookupByLibrary.simpleMessage("设置"),
        "spawnCreator": MessageLookupByLibrary.simpleMessage("生成创作者"),
        "title": MessageLookupByLibrary.simpleMessage("标题"),
        "to": MessageLookupByLibrary.simpleMessage("至"),
        "token_id": MessageLookupByLibrary.simpleMessage("Token Principal"),
        "token_index": MessageLookupByLibrary.simpleMessage("Token Id"),
        "total_amount": MessageLookupByLibrary.simpleMessage("总金额"),
        "transaction_record": MessageLookupByLibrary.simpleMessage("转账记录"),
        "transfer": MessageLookupByLibrary.simpleMessage("转账"),
        "transfer_amount": MessageLookupByLibrary.simpleMessage("转账数量"),
        "transfer_success": MessageLookupByLibrary.simpleMessage("转账成功!"),
        "update_sell": MessageLookupByLibrary.simpleMessage("更改出售"),
        "version": MessageLookupByLibrary.simpleMessage("版本"),
        "wallet": MessageLookupByLibrary.simpleMessage("钱包"),
        "wallet_created_hint": MessageLookupByLibrary.simpleMessage("钱包已创建"),
        "wallet_exists_hint": MessageLookupByLibrary.simpleMessage("钱包已存在"),
        "wallet_manage": MessageLookupByLibrary.simpleMessage("钱包管理"),
        "work_room": MessageLookupByLibrary.simpleMessage("工作室"),
        "wrong_guesture_password_hint": m0,
        "wrong_mnemonic_words_sequences":
            MessageLookupByLibrary.simpleMessage("助记词顺序错误")
      };
}
