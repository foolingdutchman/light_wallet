import 'dart:math';

import 'package:agent_dart/agent_dart.dart';
import 'package:agent_dart/wallet/types.dart';
import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';

class RosettaUtils {
  static RosettaApi? _rosettaApi;
  static bool isInit = false;

  static Future<void> init() async {
    _rosettaApi = new RosettaApi();
    await _rosettaApi?.init();
    isInit = true;
  }

  static getBlockByHeight(BigInt blockHeight) async {
    BlockResponse resp = await _rosettaApi!.blockByIndex(blockHeight.toInt());
    print(resp.toJson());
  }

  static Future<List<RosettaTransactionRecord>> getWalletTransactions(
      Wallet wallet) async {
    SearchTransactionsResponse? resp =
        await _rosettaApi?.transactionsByAccount(wallet.address);
    print('transaction length is ' + resp!.transactions.length.toString());
    for (var i = 0; i < resp.transactions.length; i++) {
      print('index is ' + i.toString());
      print('transaction is :' +
          resp.transactions[i].transaction.toJson().toString());
    }

    return RosettaTransactionRecord.fromRosettaTransactionList(
        resp.transactions);
  }

  static void transactionsByAccount(String accountAddress,
      {invokeTransactions}) async {
    Future<SearchTransactionsResponse>? resp =
        _rosettaApi?.transactionsByAccount(accountAddress);
    resp!
        .then((value) => invokeTransactions(value.transactions))
        .onError((error, stackTrace) => print('error is' + error.toString()));
  }

  static Future<Wallet> getWalletBalance(Wallet wallet) async {
    AccountBalanceResponse? resp =
        await _rosettaApi?.accountBalanceByAddress(wallet.address);
    for (var i = 0; i < resp!.balances.length; i++) {
      Amount amount = resp.balances[i];
      if (wallet.tokenList
          .any((token) => token.symbol == amount.currency.symbol)) {
        wallet.tokenList
                .firstWhere((token) => token.symbol == amount.currency.symbol)
                .balance =
            double.parse(amount.value) / pow(10, amount.currency.decimals);
      }
    }
    return wallet;
  }
}

class RosettaTransactionRecord {
  String from = '';
  int timeStamp = 0;
  double amount = 0;
  String to = '';
  double fee = 0;
  String status = '';
  String hash = '';
  int memo = 0;

  RosettaTransactionRecord(
      {String from = '',
      String to = '',
      String status = '',
      String hash = '',
      int memo = 0,
      double amount = 0,
      double fee = 0,
      int timeStamp = 0}) {
    this.amount = amount;
    this.fee = fee;
    this.from = from;
    this.to = to;
    this.timeStamp = timeStamp;
    this.status = status;
    this.memo = memo;
  }

  bool isWalletReceive(Wallet? wallet) {
    return to == wallet?.address;
  }

  static RosettaTransactionRecord fromRosettaTransaction(
      Transaction rosettaTrans) {
    List<Operation> operations = rosettaTrans.operations;
    int stamp = 0;
    int memo = 0;
    rosettaTrans.metadata?.forEach((key, value) {
      if (key == 'timestamp') {
        stamp = value;
        print('datetime is :' + StringUtil.longTimeStampToDateString(stamp));
      } else if (key == 'memo') {
        memo = value;
        print('memo is :' + memo.toString());
      }
    });

    return new RosettaTransactionRecord(
        from: operations[0].account?.address ?? '',
        to: operations[1].account?.address ?? '',
        amount: double.parse(operations[1].amount?.value ?? '0') /
            (1000 * 1000 * 100),
        fee: double.parse(operations[2].amount?.value ?? '0') /
            (1000 * 1000 * 100),
        timeStamp: stamp,
        hash: rosettaTrans.transaction_identifier.hash,
        memo: memo,
        status: operations[0].status ?? '');
  }

  static List<RosettaTransactionRecord> fromRosettaTransactionList(
      List<BlockTransaction> blockTransactions) {
    return blockTransactions
        .map((blockTransaction) =>
            fromRosettaTransaction(blockTransaction.transaction))
        .toList();
  }
}
