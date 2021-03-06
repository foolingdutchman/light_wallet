// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(left_time) =>
      "Wrong Password Input, you have ${left_time} left to try";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activate_fingerprint_password": MessageLookupByLibrary.simpleMessage(
            "Activate Fingerprint Password"),
        "activate_guester_password":
            MessageLookupByLibrary.simpleMessage("Activate Gesture Password"),
        "activate_local_auth": MessageLookupByLibrary.simpleMessage(
            "Activiate Biometric Authentication"),
        "add_wallet": MessageLookupByLibrary.simpleMessage("Add Wallet"),
        "address": MessageLookupByLibrary.simpleMessage("Address"),
        "amount": MessageLookupByLibrary.simpleMessage("Amount"),
        "appName": MessageLookupByLibrary.simpleMessage("LWallet"),
        "assetList": MessageLookupByLibrary.simpleMessage("Assets List"),
        "author": MessageLookupByLibrary.simpleMessage("Author"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "balance": MessageLookupByLibrary.simpleMessage("Balance"),
        "block_height": MessageLookupByLibrary.simpleMessage("Block Height"),
        "burn": MessageLookupByLibrary.simpleMessage("Burn"),
        "buy": MessageLookupByLibrary.simpleMessage("Buy"),
        "cancel_sell": MessageLookupByLibrary.simpleMessage("Cancel Sell"),
        "change_price": MessageLookupByLibrary.simpleMessage("Change Price"),
        "click_to_load_more":
            MessageLookupByLibrary.simpleMessage("Click to load More..."),
        "collect": MessageLookupByLibrary.simpleMessage("Collect"),
        "comfirm_mnemonic_backup": MessageLookupByLibrary.simpleMessage(
            "Confirm Mnemonic Been Backup"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirm_import_mnemonic":
            MessageLookupByLibrary.simpleMessage("Confirm Import Mnemonic"),
        "confirm_mnemonic":
            MessageLookupByLibrary.simpleMessage("Confirm Mnemonic"),
        "copy_mnemonic": MessageLookupByLibrary.simpleMessage("Copy Mnemonic"),
        "copyright_declearation": MessageLookupByLibrary.simpleMessage(
            "Please make sure that the content of the NFT work you create is an original work, and any copyright-related disputes arising from this work have nothing to do with the platform."),
        "counter_address":
            MessageLookupByLibrary.simpleMessage("Counter Address"),
        "create_wallet": MessageLookupByLibrary.simpleMessage("Create Wallet"),
        "creator_id": MessageLookupByLibrary.simpleMessage("Creator Principal"),
        "creator_principal":
            MessageLookupByLibrary.simpleMessage("Creator Principal"),
        "current_address":
            MessageLookupByLibrary.simpleMessage("Current Wallet Address"),
        "current_remaining_canister_space":
            MessageLookupByLibrary.simpleMessage(
                "Current Canister Remaining Space"),
        "data_not_ready":
            MessageLookupByLibrary.simpleMessage("Data is not ready..."),
        "delete_wallet": MessageLookupByLibrary.simpleMessage("Delete Wallet"),
        "desc": MessageLookupByLibrary.simpleMessage("Description"),
        "emport_mnemonic":
            MessageLookupByLibrary.simpleMessage("Export Mnemonic"),
        "empty_password_hint":
            MessageLookupByLibrary.simpleMessage("Password can not be empty"),
        "export_mnemonic":
            MessageLookupByLibrary.simpleMessage("Export Mnemonic"),
        "fee": MessageLookupByLibrary.simpleMessage("Fee"),
        "fingerprint_auth":
            MessageLookupByLibrary.simpleMessage("Fingerprint Authentication"),
        "from": MessageLookupByLibrary.simpleMessage("From"),
        "guesture_password_settled": MessageLookupByLibrary.simpleMessage(
            "Gesture Password has been set"),
        "has_copy_to_clipboard": MessageLookupByLibrary.simpleMessage(
            "content has copied to clipboard"),
        "hint_burn_token": MessageLookupByLibrary.simpleMessage(
            "Burnt Token will be destoried forever!"),
        "hint_icp_not_enough": MessageLookupByLibrary.simpleMessage(
            "Your ICP blance is not enough!"),
        "hint_save_code_failded":
            MessageLookupByLibrary.simpleMessage("Save faild"),
        "hint_save_code_success": MessageLookupByLibrary.simpleMessage(
            "2D Code has been save to gallery"),
        "hint_unsupport_local_auth": MessageLookupByLibrary.simpleMessage(
            "Your Device not support Biometric Authentication"),
        "import_mnemonic":
            MessageLookupByLibrary.simpleMessage("Import Mnemonic"),
        "import_wallet": MessageLookupByLibrary.simpleMessage("Import Wallet"),
        "important_notice":
            MessageLookupByLibrary.simpleMessage("Important Notice"),
        "input_author": MessageLookupByLibrary.simpleMessage("Input Author"),
        "input_desc": MessageLookupByLibrary.simpleMessage("Input Description"),
        "input_guesture_password":
            MessageLookupByLibrary.simpleMessage("Input Gesture Password"),
        "input_mnemonic":
            MessageLookupByLibrary.simpleMessage("Input Mnemonic"),
        "input_orignal_password":
            MessageLookupByLibrary.simpleMessage("Input Original Password"),
        "input_password":
            MessageLookupByLibrary.simpleMessage("Input Password"),
        "input_password_again":
            MessageLookupByLibrary.simpleMessage("Input Password Again"),
        "input_title": MessageLookupByLibrary.simpleMessage("Input Title"),
        "invalid_address_hint": MessageLookupByLibrary.simpleMessage(
            "Please input valid ICP address"),
        "invalid_amount_hint": MessageLookupByLibrary.simpleMessage(
            "Please input valid ICP amount"),
        "invalid_principal":
            MessageLookupByLibrary.simpleMessage("Invalid principal..."),
        "invoice": MessageLookupByLibrary.simpleMessage("Invoice"),
        "invoice_no": MessageLookupByLibrary.simpleMessage("Invoice No"),
        "invoice_type": MessageLookupByLibrary.simpleMessage("Invoice Type"),
        "issue_date": MessageLookupByLibrary.simpleMessage("Issue Date"),
        "loading_data": MessageLookupByLibrary.simpleMessage("Loading data..."),
        "local_auth":
            MessageLookupByLibrary.simpleMessage("Biometric Authentication"),
        "make_nft": MessageLookupByLibrary.simpleMessage("Make NFT"),
        "make_your_nft":
            MessageLookupByLibrary.simpleMessage("Make Your Own NFT Art"),
        "manage": MessageLookupByLibrary.simpleMessage("Manage"),
        "max_amount": MessageLookupByLibrary.simpleMessage("Max Amount"),
        "mine": MessageLookupByLibrary.simpleMessage("Mine"),
        "mint": MessageLookupByLibrary.simpleMessage("Mint"),
        "mint_cost": MessageLookupByLibrary.simpleMessage("Mint Cost"),
        "mnemonic_format_incorrect":
            MessageLookupByLibrary.simpleMessage("Mnemonic Format Incorrect"),
        "modify_guesture_password":
            MessageLookupByLibrary.simpleMessage("Modify Gesture Password"),
        "modify_password":
            MessageLookupByLibrary.simpleMessage("Modify Password"),
        "my_invoice": MessageLookupByLibrary.simpleMessage("My Invoices"),
        "my_nft": MessageLookupByLibrary.simpleMessage("My Nft"),
        "my_transactions":
            MessageLookupByLibrary.simpleMessage("My Transactions"),
        "new_guesture_password":
            MessageLookupByLibrary.simpleMessage("Input New Gesture Password"),
        "nft": MessageLookupByLibrary.simpleMessage("NFT"),
        "nft_detail": MessageLookupByLibrary.simpleMessage("Nft Detail"),
        "no_more_data": MessageLookupByLibrary.simpleMessage("No more data"),
        "not_sell": MessageLookupByLibrary.simpleMessage("Not Sell"),
        "os_determine_auth": MessageLookupByLibrary.simpleMessage(
            "Let OS determine authentication method"),
        "owner_id": MessageLookupByLibrary.simpleMessage("Owner Principal"),
        "password_input_hint":
            MessageLookupByLibrary.simpleMessage("Please Input Password"),
        "password_insist_hint": MessageLookupByLibrary.simpleMessage(
            "Password input not insist with previous one"),
        "password_modified_hint":
            MessageLookupByLibrary.simpleMessage("Password already modified"),
        "password_verified":
            MessageLookupByLibrary.simpleMessage("Password has been Verified!"),
        "password_wrong_hint":
            MessageLookupByLibrary.simpleMessage("Wrong Password Input"),
        "pay_the_bill": MessageLookupByLibrary.simpleMessage("Pay the Bill"),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "pricinpal_id": MessageLookupByLibrary.simpleMessage("Pricinpal ID"),
        "purchase": MessageLookupByLibrary.simpleMessage("Purchase"),
        "purchase_price":
            MessageLookupByLibrary.simpleMessage("Purchase Price"),
        "receipt_address":
            MessageLookupByLibrary.simpleMessage("Receipt Address"),
        "receipt_principal":
            MessageLookupByLibrary.simpleMessage("Receipt Principal"),
        "record": MessageLookupByLibrary.simpleMessage("Record"),
        "repeat_guesture_password":
            MessageLookupByLibrary.simpleMessage("Repeat Gesture Password"),
        "save_2d_code": MessageLookupByLibrary.simpleMessage("Save 2D Code"),
        "save_mnemonic": MessageLookupByLibrary.simpleMessage("Save Mnemonic"),
        "select_as_default_wallet":
            MessageLookupByLibrary.simpleMessage("Set as default wallet"),
        "select_default_wallet_hint": MessageLookupByLibrary.simpleMessage(
            "Has been set as default wallet"),
        "select_mnemonic_words":
            MessageLookupByLibrary.simpleMessage("Select Mnemonic words"),
        "select_your_art":
            MessageLookupByLibrary.simpleMessage("Select your Art!"),
        "sell": MessageLookupByLibrary.simpleMessage("Sell"),
        "seller_address":
            MessageLookupByLibrary.simpleMessage("Seller Address"),
        "set_guesture_password":
            MessageLookupByLibrary.simpleMessage("Set Gesture Password"),
        "set_price": MessageLookupByLibrary.simpleMessage("Set Price"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "spawnCreator": MessageLookupByLibrary.simpleMessage("Spawn Creator"),
        "title": MessageLookupByLibrary.simpleMessage("Title"),
        "to": MessageLookupByLibrary.simpleMessage("To"),
        "token_id": MessageLookupByLibrary.simpleMessage("Token Principal"),
        "token_index": MessageLookupByLibrary.simpleMessage("Token Id"),
        "total_amount": MessageLookupByLibrary.simpleMessage("Total Amount"),
        "transaction_record":
            MessageLookupByLibrary.simpleMessage("Transactions Record"),
        "transfer": MessageLookupByLibrary.simpleMessage("Transfer"),
        "transfer_amount":
            MessageLookupByLibrary.simpleMessage("Transfer Amount"),
        "transfer_success":
            MessageLookupByLibrary.simpleMessage("Transfer Success!"),
        "update_sell": MessageLookupByLibrary.simpleMessage("Update Sell"),
        "version": MessageLookupByLibrary.simpleMessage("Version"),
        "wallet": MessageLookupByLibrary.simpleMessage("Wallet"),
        "wallet_created_hint":
            MessageLookupByLibrary.simpleMessage("Wallet already created"),
        "wallet_exists_hint":
            MessageLookupByLibrary.simpleMessage("Wallet already exists"),
        "wallet_manage":
            MessageLookupByLibrary.simpleMessage("Wallet Management"),
        "work_room": MessageLookupByLibrary.simpleMessage("WorkRoom"),
        "wrong_guesture_password_hint": m0,
        "wrong_mnemonic_words_sequences": MessageLookupByLibrary.simpleMessage(
            "Wrong Mnemonic Words Sequences")
      };
}
