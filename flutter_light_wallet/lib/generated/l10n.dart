// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `LWallet`
  String get appName {
    return Intl.message(
      'LWallet',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Assets List`
  String get assetList {
    return Intl.message(
      'Assets List',
      name: 'assetList',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Export Mnemonic`
  String get emport_mnemonic {
    return Intl.message(
      'Export Mnemonic',
      name: 'emport_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `Modify Password`
  String get modify_password {
    return Intl.message(
      'Modify Password',
      name: 'modify_password',
      desc: '',
      args: [],
    );
  }

  /// `Delete Wallet`
  String get delete_wallet {
    return Intl.message(
      'Delete Wallet',
      name: 'delete_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Please input valid ICP address`
  String get invalid_address_hint {
    return Intl.message(
      'Please input valid ICP address',
      name: 'invalid_address_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please input valid ICP amount`
  String get invalid_amount_hint {
    return Intl.message(
      'Please input valid ICP amount',
      name: 'invalid_amount_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password has been Verified!`
  String get password_verified {
    return Intl.message(
      'Password has been Verified!',
      name: 'password_verified',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get transfer {
    return Intl.message(
      'Transfer',
      name: 'transfer',
      desc: '',
      args: [],
    );
  }

  /// `Collect`
  String get collect {
    return Intl.message(
      'Collect',
      name: 'collect',
      desc: '',
      args: [],
    );
  }

  /// `Record`
  String get record {
    return Intl.message(
      'Record',
      name: 'record',
      desc: '',
      args: [],
    );
  }

  /// `Current Wallet Address`
  String get current_address {
    return Intl.message(
      'Current Wallet Address',
      name: 'current_address',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Amount`
  String get transfer_amount {
    return Intl.message(
      'Transfer Amount',
      name: 'transfer_amount',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Max Amount`
  String get max_amount {
    return Intl.message(
      'Max Amount',
      name: 'max_amount',
      desc: '',
      args: [],
    );
  }

  /// `Receipt Address`
  String get receipt_address {
    return Intl.message(
      'Receipt Address',
      name: 'receipt_address',
      desc: '',
      args: [],
    );
  }

  /// `Fee`
  String get fee {
    return Intl.message(
      'Fee',
      name: 'fee',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Has been set as default wallet`
  String get select_default_wallet_hint {
    return Intl.message(
      'Has been set as default wallet',
      name: 'select_default_wallet_hint',
      desc: '',
      args: [],
    );
  }

  /// `Set as default wallet`
  String get select_as_default_wallet {
    return Intl.message(
      'Set as default wallet',
      name: 'select_as_default_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Success!`
  String get transfer_success {
    return Intl.message(
      'Transfer Success!',
      name: 'transfer_success',
      desc: '',
      args: [],
    );
  }

  /// `Block Height`
  String get block_height {
    return Intl.message(
      'Block Height',
      name: 'block_height',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Activate Gesture Password`
  String get activate_guester_password {
    return Intl.message(
      'Activate Gesture Password',
      name: 'activate_guester_password',
      desc: '',
      args: [],
    );
  }

  /// `Activate Fingerprint Password`
  String get activate_fingerprint_password {
    return Intl.message(
      'Activate Fingerprint Password',
      name: 'activate_fingerprint_password',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `No more data`
  String get no_more_data {
    return Intl.message(
      'No more data',
      name: 'no_more_data',
      desc: '',
      args: [],
    );
  }

  /// `Transactions Record`
  String get transaction_record {
    return Intl.message(
      'Transactions Record',
      name: 'transaction_record',
      desc: '',
      args: [],
    );
  }

  /// `Password can not be empty`
  String get empty_password_hint {
    return Intl.message(
      'Password can not be empty',
      name: 'empty_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Wallet already exists`
  String get wallet_exists_hint {
    return Intl.message(
      'Wallet already exists',
      name: 'wallet_exists_hint',
      desc: '',
      args: [],
    );
  }

  /// `Wallet already created`
  String get wallet_created_hint {
    return Intl.message(
      'Wallet already created',
      name: 'wallet_created_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password already modified`
  String get password_modified_hint {
    return Intl.message(
      'Password already modified',
      name: 'password_modified_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password input not insist with previous one`
  String get password_insist_hint {
    return Intl.message(
      'Password input not insist with previous one',
      name: 'password_insist_hint',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Password Input`
  String get password_wrong_hint {
    return Intl.message(
      'Wrong Password Input',
      name: 'password_wrong_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please Input Password`
  String get password_input_hint {
    return Intl.message(
      'Please Input Password',
      name: 'password_input_hint',
      desc: '',
      args: [],
    );
  }

  /// `Input Password`
  String get input_password {
    return Intl.message(
      'Input Password',
      name: 'input_password',
      desc: '',
      args: [],
    );
  }

  /// `Input Original Password`
  String get input_orignal_password {
    return Intl.message(
      'Input Original Password',
      name: 'input_orignal_password',
      desc: '',
      args: [],
    );
  }

  /// `Input Password Again`
  String get input_password_again {
    return Intl.message(
      'Input Password Again',
      name: 'input_password_again',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Mnemonic Been Backup`
  String get comfirm_mnemonic_backup {
    return Intl.message(
      'Confirm Mnemonic Been Backup',
      name: 'comfirm_mnemonic_backup',
      desc: '',
      args: [],
    );
  }

  /// `Mnemonic Format Incorrect`
  String get mnemonic_format_incorrect {
    return Intl.message(
      'Mnemonic Format Incorrect',
      name: 'mnemonic_format_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Import Mnemonic`
  String get confirm_import_mnemonic {
    return Intl.message(
      'Confirm Import Mnemonic',
      name: 'confirm_import_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `Import Mnemonic`
  String get import_mnemonic {
    return Intl.message(
      'Import Mnemonic',
      name: 'import_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `Input Mnemonic`
  String get input_mnemonic {
    return Intl.message(
      'Input Mnemonic',
      name: 'input_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `Manage`
  String get manage {
    return Intl.message(
      'Manage',
      name: 'manage',
      desc: '',
      args: [],
    );
  }

  /// `Mine`
  String get mine {
    return Intl.message(
      'Mine',
      name: 'mine',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Export Mnemonic`
  String get export_mnemonic {
    return Intl.message(
      'Export Mnemonic',
      name: 'export_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Mnemonic`
  String get confirm_mnemonic {
    return Intl.message(
      'Confirm Mnemonic',
      name: 'confirm_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `Select Mnemonic words`
  String get select_mnemonic_words {
    return Intl.message(
      'Select Mnemonic words',
      name: 'select_mnemonic_words',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Mnemonic Words Sequences`
  String get wrong_mnemonic_words_sequences {
    return Intl.message(
      'Wrong Mnemonic Words Sequences',
      name: 'wrong_mnemonic_words_sequences',
      desc: '',
      args: [],
    );
  }

  /// `Add Wallet`
  String get add_wallet {
    return Intl.message(
      'Add Wallet',
      name: 'add_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Gesture Password has been set`
  String get guesture_password_settled {
    return Intl.message(
      'Gesture Password has been set',
      name: 'guesture_password_settled',
      desc: '',
      args: [],
    );
  }

  /// `Modify Gesture Password`
  String get modify_guesture_password {
    return Intl.message(
      'Modify Gesture Password',
      name: 'modify_guesture_password',
      desc: '',
      args: [],
    );
  }

  /// `Repeat Gesture Password`
  String get repeat_guesture_password {
    return Intl.message(
      'Repeat Gesture Password',
      name: 'repeat_guesture_password',
      desc: '',
      args: [],
    );
  }

  /// `Input New Gesture Password`
  String get new_guesture_password {
    return Intl.message(
      'Input New Gesture Password',
      name: 'new_guesture_password',
      desc: '',
      args: [],
    );
  }

  /// `Set Gesture Password`
  String get set_guesture_password {
    return Intl.message(
      'Set Gesture Password',
      name: 'set_guesture_password',
      desc: '',
      args: [],
    );
  }

  /// `Input Gesture Password`
  String get input_guesture_password {
    return Intl.message(
      'Input Gesture Password',
      name: 'input_guesture_password',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Password Input, you have {left_time} left to try`
  String wrong_guesture_password_hint(Object left_time) {
    return Intl.message(
      'Wrong Password Input, you have $left_time left to try',
      name: 'wrong_guesture_password_hint',
      desc: '',
      args: [left_time],
    );
  }

  /// `Create Wallet`
  String get create_wallet {
    return Intl.message(
      'Create Wallet',
      name: 'create_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Import Wallet`
  String get import_wallet {
    return Intl.message(
      'Import Wallet',
      name: 'import_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Pricinpal ID`
  String get pricinpal_id {
    return Intl.message(
      'Pricinpal ID',
      name: 'pricinpal_id',
      desc: '',
      args: [],
    );
  }

  /// `Save Mnemonic`
  String get save_mnemonic {
    return Intl.message(
      'Save Mnemonic',
      name: 'save_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `Copy Mnemonic`
  String get copy_mnemonic {
    return Intl.message(
      'Copy Mnemonic',
      name: 'copy_mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `content has copied to clipboard`
  String get has_copy_to_clipboard {
    return Intl.message(
      'content has copied to clipboard',
      name: 'has_copy_to_clipboard',
      desc: '',
      args: [],
    );
  }

  /// `Let OS determine authentication method`
  String get os_determine_auth {
    return Intl.message(
      'Let OS determine authentication method',
      name: 'os_determine_auth',
      desc: '',
      args: [],
    );
  }

  /// `Fingerprint Authentication`
  String get fingerprint_auth {
    return Intl.message(
      'Fingerprint Authentication',
      name: 'fingerprint_auth',
      desc: '',
      args: [],
    );
  }

  /// `Biometric Authentication`
  String get local_auth {
    return Intl.message(
      'Biometric Authentication',
      name: 'local_auth',
      desc: '',
      args: [],
    );
  }

  /// `Activiate Biometric Authentication`
  String get activate_local_auth {
    return Intl.message(
      'Activiate Biometric Authentication',
      name: 'activate_local_auth',
      desc: '',
      args: [],
    );
  }

  /// `Your Device not support Biometric Authentication`
  String get hint_unsupport_local_auth {
    return Intl.message(
      'Your Device not support Biometric Authentication',
      name: 'hint_unsupport_local_auth',
      desc: '',
      args: [],
    );
  }

  /// `Save 2D Code`
  String get save_2d_code {
    return Intl.message(
      'Save 2D Code',
      name: 'save_2d_code',
      desc: '',
      args: [],
    );
  }

  /// `2D Code has been save to gallery`
  String get hint_save_code_success {
    return Intl.message(
      '2D Code has been save to gallery',
      name: 'hint_save_code_success',
      desc: '',
      args: [],
    );
  }

  /// `Save faild`
  String get hint_save_code_failded {
    return Intl.message(
      'Save faild',
      name: 'hint_save_code_failded',
      desc: '',
      args: [],
    );
  }

  /// `WorkRoom`
  String get work_room {
    return Intl.message(
      'WorkRoom',
      name: 'work_room',
      desc: '',
      args: [],
    );
  }

  /// `Make NFT`
  String get make_nft {
    return Intl.message(
      'Make NFT',
      name: 'make_nft',
      desc: '',
      args: [],
    );
  }

  /// `Spawn Creator`
  String get spawnCreator {
    return Intl.message(
      'Spawn Creator',
      name: 'spawnCreator',
      desc: '',
      args: [],
    );
  }

  /// `Input Author`
  String get input_author {
    return Intl.message(
      'Input Author',
      name: 'input_author',
      desc: '',
      args: [],
    );
  }

  /// `Input Title`
  String get input_title {
    return Intl.message(
      'Input Title',
      name: 'input_title',
      desc: '',
      args: [],
    );
  }

  /// `Input Description`
  String get input_desc {
    return Intl.message(
      'Input Description',
      name: 'input_desc',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Author`
  String get author {
    return Intl.message(
      'Author',
      name: 'author',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get desc {
    return Intl.message(
      'Description',
      name: 'desc',
      desc: '',
      args: [],
    );
  }

  /// `Owner Id`
  String get owner_id {
    return Intl.message(
      'Owner Id',
      name: 'owner_id',
      desc: '',
      args: [],
    );
  }

  /// `Creator Id`
  String get creator_id {
    return Intl.message(
      'Creator Id',
      name: 'creator_id',
      desc: '',
      args: [],
    );
  }

  /// `Token Id`
  String get token_id {
    return Intl.message(
      'Token Id',
      name: 'token_id',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get buy {
    return Intl.message(
      'Buy',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `Not For Sell`
  String get not_for_sell {
    return Intl.message(
      'Not For Sell',
      name: 'not_for_sell',
      desc: '',
      args: [],
    );
  }

  /// `Sell`
  String get sell {
    return Intl.message(
      'Sell',
      name: 'sell',
      desc: '',
      args: [],
    );
  }

  /// `Update Sell`
  String get update_sell {
    return Intl.message(
      'Update Sell',
      name: 'update_sell',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Sell`
  String get cancel_sell {
    return Intl.message(
      'Cancel Sell',
      name: 'cancel_sell',
      desc: '',
      args: [],
    );
  }

  /// `Change Price`
  String get change_price {
    return Intl.message(
      'Change Price',
      name: 'change_price',
      desc: '',
      args: [],
    );
  }

  /// `Set Price`
  String get set_price {
    return Intl.message(
      'Set Price',
      name: 'set_price',
      desc: '',
      args: [],
    );
  }

  /// `Creator Principal`
  String get creator_principal {
    return Intl.message(
      'Creator Principal',
      name: 'creator_principal',
      desc: '',
      args: [],
    );
  }

  /// `Current Canister Remaining Space`
  String get current_remaining_canister_space {
    return Intl.message(
      'Current Canister Remaining Space',
      name: 'current_remaining_canister_space',
      desc: '',
      args: [],
    );
  }

  /// `Important Notice`
  String get important_notice {
    return Intl.message(
      'Important Notice',
      name: 'important_notice',
      desc: '',
      args: [],
    );
  }

  /// `Please make sure that the content of the NFT work you create is an original work, and any copyright-related disputes arising from this work have nothing to do with the platform.`
  String get copyright_declearation {
    return Intl.message(
      'Please make sure that the content of the NFT work you create is an original work, and any copyright-related disputes arising from this work have nothing to do with the platform.',
      name: 'copyright_declearation',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Management`
  String get wallet_manage {
    return Intl.message(
      'Wallet Management',
      name: 'wallet_manage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
