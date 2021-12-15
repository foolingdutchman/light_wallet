import 'dart:math';
import 'dart:typed_data';

import 'package:agent_dart/wallet/ledger.dart';

import 'package:agent_dart/agent_dart.dart';
import 'package:agent_dart/wallet/keysmith.dart' as keysmith;
import 'package:flutter_light_wallet/model/token.dart';
import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/utils/constans.dart';
import 'package:flutter_light_wallet/utils/time_util.dart';

class ICPAccountUtils {
  static String generateBip39Mnemonic() {
    String m = keysmith.genrateMnemonic();
    print('Mnemonic is : ' + m);
    return m;
  }

  static Wallet generateWallet(String password, String mnemonic) {
    ICPSigner signer = ICPSigner.fromPhrase(mnemonic);
    String signerecPricinpal =
        signer.account.ecIdentity?.getPrincipal().toString() ?? '';
    String signerecKey = signer.account.ecKeys?.ecPrivateKey?.toHex() ?? '';
    String signerecChecksumAddress = signer.ecChecksumAddress ?? '';
    Token token = Token('ICP', 0);
    print('ICP ACCOUNT INFO: \n signerecPricinpal : ' +
        signerecPricinpal +
        " \n signerecKey : " +
        signerecKey +
        " \n signerecChecksumAddress is : " +
        signerecChecksumAddress);

    Wallet wallet = Wallet(
      [token],
      mnomenic: mnemonic,
      principal: signerecPricinpal,
      address: signerecChecksumAddress,
      secrectKey: signerecKey,
      password: password,
    );
    return wallet;
  }

  static Future<BigInt> transfer(
      Wallet? wallet, String toAddress, String amount,
      {String? memoString}) async {
    AgentFactory agent = await prepareAgent(wallet);

    var blockHeight = await Ledger.send(
        agent: agent,
        to: toAddress,
        amount: BigInt.from(num.parse(amount) * 100000000),
        sendOpts: SendOpts()
          ..fee = BigInt.from(10000)
          ..memo =
              memoString == null ? null : memoString.plainToHex().hexToBn());
    print('Transaction is completed! The blockHeight is ' +
        blockHeight.toString());
    return blockHeight;
  }

  static Future<Wallet> getIcpBalance(Wallet wallet) async {
    AgentFactory agent = await prepareAgent(wallet);
    ICPTs? bigIntBalance =
        await Ledger.getBalance(agent: agent, accountId: wallet.address);
    double balance = (bigIntBalance.e8s / BigInt.from(pow(10, 8))).toDouble();
    wallet.tokenList[0].balance = balance;
    return wallet;
  }

  static Future<AgentFactory> prepareAgent(Wallet? wallet) async {
    ICPSigner signer = ICPSigner.fromPhrase(wallet?.mnomenic ?? '');
    return await AgentFactory.createAgent(
        canisterId: Constants.LOCAL_LEDGER_CANISTER_ID,
        // local ledger canister id, should change accourdingly
        url: Constants.LOCAL_NETWORK_VIRTUAL_DEVICE_ADDRESS,
        // For Android emulator, please use 10.0.2.2 as endpoint
        idl: ledgerIdl,
        identity: signer.account.ecIdentity,
        debug: true);
  }

  static Identity? getWalletIdentity(Wallet? wallet) {
    ICPSigner signer = ICPSigner.fromPhrase(wallet?.mnomenic ?? '');
    return signer.account.ecIdentity;
  }

  static Principal createPrincipal(Uint8List bytes) {
    var sha = sha224Hash(bytes.buffer);
    var u8a = Uint8List.fromList([...sha, SELF_AUTHENTICATING_SUFFIX]);
    return Principal(u8a);
  }

  static String  createTempPrincipalString(){

    return createPrincipal(TimeUtil.currentTImeMillis().toU8a()).toString();
  }

}
