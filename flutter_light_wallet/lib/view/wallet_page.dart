

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_page_state.dart';
import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/rosetta_utils.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState('wallet-page-detector');
}

class _WalletPageState extends BasePageState<WalletPage> {
  Wallet? wallet;
  bool _visibility = true;

  _WalletPageState(String observerKey) : super(observerKey);

  void addressCopy(BuildContext context, Wallet? wallet) {
    print(" copy clicked!");
    StringUtil.copyTexttoClipboard(wallet?.address ?? '');
  }

  void _onVisibleClick() {
    print(" visibility  clicked!");
    setState(() {
      print(" visibility before click is " + _visibility.toString());
      _visibility = !_visibility;
      print(" visibility after click is " + _visibility.toString());
    });
  }

  void onFirstVisible() {
    _updateWalletBalance();
  }

  void onVisible() {}

  @override
  void initState() {
    _visibility = true;
    wallet = InstanceStore.currentWallet;
    super.initState();
  }

  Future<void> _refreshData() async {
    InstanceStore.isBlanceUpdated = false;
    await _updateWalletBalance();

    print('refresh********  refreshCompleted finished!');
  }

  Future<void> _updateWalletBalance() async {
    if (!InstanceStore.isBlanceUpdated) {
      print('refresh********* is update wallet balance called!');
      SmartDialog.showLoading();
      await RosettaUtils.getWalletBalance(wallet!);

      print('refresh********** network call finished!');
      InstanceStore.isBlanceUpdated = true;
      SmartDialog.dismiss();
      setState(() {});
    }
  }

  @override
  Widget constructView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
              color: Colors.blue[300],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      '钱包',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '余额:',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _visibility
                                      ? (wallet?.getICPBalance().toString() ??
                                              '0') +
                                          ' ICP'
                                      : '**.**',
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              InkWell(
                                onTap: () => _onVisibleClick(),
                                child: Container(
                                  child: Icon(
                                    _visibility
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white70,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Address:',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _visibility ? wallet?.address ?? '' : '*****',
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white70),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: InkWell(
                                  onTap: () => addressCopy(context, wallet),
                                  child: Container(
                                    child: Icon(
                                      Icons.copy,
                                      color: Colors.white54,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      '资产列表',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LiquidPullToRefresh(
                height: 50,
                color: Colors.blue[300],
                showChildOpacityTransition: false,
                animSpeedFactor: 2,
                onRefresh: () {
                  return _refreshData();
                },
                child: ListView.separated(
                    itemBuilder: (context, posiotn) => Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Row(children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    image: new DecorationImage(
                                      image: new ExactAssetImage(
                                          'assets/images/ic_icp.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                wallet!.tokenList[posiotn].symbol,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Expanded(child: Container()),
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Text(
                                wallet!.tokenList[posiotn].balance.toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ]),
                        ),
                    separatorBuilder: (_, i) => Divider(
                          color: Colors.black12,
                          thickness: 1,
                        ),
                    itemCount: wallet!.tokenList.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void hanldEvent(Event event) {
    if (event is SwitchWalletEvent || event is DeleteWalletEvent) {
      InstanceStore.needRefreshData();
      setState(() {
        wallet = InstanceStore.currentWallet;
      });
    }
  }
}
