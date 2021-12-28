


import 'package:flutter_light_wallet/utils/nft_canister.dart';

import 'Instance_store.dart';
import 'constans.dart';
import 'icp_account_utils.dart';

class CanisterUtil{
 static WalletCanister? walletCanister;
 static bool isCanisterInit =false;

  static Future<WalletCanister?> initWalletCanister() async{

      // initialize counter, change canister id here

      walletCanister = WalletCanister(
          canisterId: Constants.IC_NFT_CANISTER_ID,
          url: Constants.ICP_NETWORK_ADDRESS);
      // set agent when other paramater comes in like new Identity
      await walletCanister?.setAgent(
          newIdentity:
          ICPAccountUtils.getWalletIdentity(InstanceStore.currentWallet));
      isCanisterInit = true;
      return walletCanister;
    }


}