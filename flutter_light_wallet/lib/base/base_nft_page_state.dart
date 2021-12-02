import 'package:agent_dart/agent_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/canister_util.dart';
import 'package:flutter_light_wallet/utils/constans.dart';
import 'package:flutter_light_wallet/utils/icp_account_utils.dart';
import 'package:flutter_light_wallet/utils/wallet_canister.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'base_page_state.dart';

abstract class BaseNftPageState<T extends StatefulWidget>
    extends BasePageState<T> {
  BaseNftPageState(String observerKey) : super(observerKey);

  WalletCanister? walletCanister;
  bool isCanisterInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    walletCanister = CanisterUtil.walletCanister;
    isCanisterInit = CanisterUtil.isCanisterInit;
  }

  _initCanister() async{
    walletCanister = await CanisterUtil.initWalletCanister();
    isCanisterInit =true;
    afterCaniterInted();
  }

  @override
  void onFirstVisible() {
    _initCanister();
  }

  @override
  void onVisible() {
    // TODO: implement onVisible
  }

  void afterCaniterInted();
}
