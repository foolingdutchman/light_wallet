import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';
import 'package:flutter_light_wallet/view/nft/nft_data_store.dart';


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
    walletCanister = NftDataStore.walletCanister;
    isCanisterInit = NftDataStore.isCanisterInit;
  }

  _initCanister() async{
   // walletCanister = await CanisterUtil.initWalletCanister();
   // isCanisterInit =true;
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
