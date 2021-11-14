
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_light_wallet/base/base_page_state.dart';
import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../utils/rosetta_utils.dart' as rosettaUtils;

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState('record-page-detector');
}

class _RecordPageState extends BasePageState<RecordPage> {
  _RecordPageState(String observerKey) : super(observerKey);
  Wallet? wallet;
  String _helpText = '';
  bool isFirstVisible = true;
  List<rosettaUtils.RosettaTransactionRecord> _transactions = [];
  @override
  Widget constructView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Container(
        padding: const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '转账记录',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
            _transactions.length == 0
                ? Container(height: 0)
                : Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: LiquidPullToRefresh(
                        height: 50,
                        color: Colors.transparent,
                        showChildOpacityTransition: false,
                        animSpeedFactor: 2,
                        onRefresh: () {
                          return _refreshData();
                        },
                        child: ListView.separated(
                          itemCount: _transactions.length,
                          itemBuilder: (context, i) {
                            return Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                height: 80,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        _transactions[i].isWalletReceive(wallet)
                                            ? Icons.arrow_downward
                                            : Icons.arrow_upward,
                                        color: _transactions[i]
                                                .isWalletReceive(wallet)
                                            ? Colors.lightBlue
                                            : Colors.redAccent,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                _transactions[i]
                                                        .isWalletReceive(wallet)
                                                    ? 'From:'
                                                    : 'To:',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Expanded(child: Container())
                                            ],
                                          ),
                                          Expanded(child: Container()),
                                          Text(
                                            _transactions[i]
                                                    .isWalletReceive(wallet)
                                                ? _transactions[i].from
                                                : _transactions[i].to,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            (_transactions[i]
                                                        .isWalletReceive(wallet)
                                                    ? '+'
                                                    : '-') +
                                                _transactions[i]
                                                    .amount
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: _transactions[i]
                                                        .isWalletReceive(wallet)
                                                    ? Colors.lightBlue
                                                    : Colors.redAccent,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            StringUtil
                                                .longTimeStampToDateString(
                                                    _transactions[i].timeStamp),
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black45),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ));
                          },
                          separatorBuilder: (context, i) => new Divider(
                            height: 1,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ),
                  ),
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Text('$_helpText'),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    wallet = InstanceStore.currentWallet;
    _transactions = InstanceStore.transactions;
    super.initState();
  }

  @override
  void hanldEvent(Event event) {
    if (event is SwitchWalletEvent || event is DeleteWalletEvent) {
      InstanceStore.needRefreshData();
      setState(() {
        wallet = InstanceStore.currentWallet;
        _transactions = [];
      });
    }
  }

  @override
  void onFirstVisible() {
    _getWalletRecord();
  }

  @override
  void onVisible() {}

  Future<void> _refreshData() async {
    InstanceStore.isRecordUpdated = false;
    _getWalletRecord();
  }

  Future<void> _getWalletRecord() async {
    if (!InstanceStore.isRecordUpdated) {
      SmartDialog.showLoading();
      List<rosettaUtils.RosettaTransactionRecord> list =
          await rosettaUtils.RosettaUtils.getWalletTransactions(wallet!);
      SmartDialog.dismiss();
      if (list.isNotEmpty) {
        InstanceStore.transactions.clear();
        InstanceStore.transactions.addAll(list);
        setState(() {
          this._transactions = InstanceStore.transactions;
        });
      } else {
        setState(() {
          this._helpText = '没有更多数据了';
        });
      }
      InstanceStore.isRecordUpdated = true;
    }
  }
}
