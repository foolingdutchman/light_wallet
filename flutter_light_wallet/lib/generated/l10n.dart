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

  /// `Activate Guesture Password`
  String get activate_guester_password {
    return Intl.message(
      'Activate Guesture Password',
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

  /// `Guesture Password has been set`
  String get guesture_password_settled {
    return Intl.message(
      'Guesture Password has been set',
      name: 'guesture_password_settled',
      desc: '',
      args: [],
    );
  }

  /// `Modify Guesture Password`
  String get modify_guesture_password {
    return Intl.message(
      'Modify Guesture Password',
      name: 'modify_guesture_password',
      desc: '',
      args: [],
    );
  }

  /// `Repeat Guesture Password`
  String get repeat_guesture_password {
    return Intl.message(
      'Repeat Guesture Password',
      name: 'repeat_guesture_password',
      desc: '',
      args: [],
    );
  }

  /// `Input New Guesture Password`
  String get new_guesture_password {
    return Intl.message(
      'Input New Guesture Password',
      name: 'new_guesture_password',
      desc: '',
      args: [],
    );
  }

  /// `Set Guesture Password`
  String get set_guesture_password {
    return Intl.message(
      'Set Guesture Password',
      name: 'set_guesture_password',
      desc: '',
      args: [],
    );
  }

  /// `Input Guesture Password`
  String get input_guesture_password {
    return Intl.message(
      'Input Guesture Password',
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