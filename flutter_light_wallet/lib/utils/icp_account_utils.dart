import 'package:agent_dart/wallet/ledger.dart';

import 'package:agent_dart/agent_dart.dart';
import 'package:agent_dart/wallet/keysmith.dart' as keysmith;
import 'package:flutter_light_wallet/model/token.dart';
import 'package:flutter_light_wallet/model/wallet.dart';

class ICPAccountUtils {
  static String generateBip39Mnemonic() {
    String m = keysmith.genrateMnemonic();
    print('Mnemonic is : ' + m);
    return m;
  }

  static Wallet generateWallet(String password, String mnemonic) {
    ICPSigner signer = ICPSigner.fromPhrase(mnemonic, passphase: password);
    String signerecPricinpal =
        signer.account.identity?.getPrincipal().toString() ?? '';
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

  static Future<String> transfer(
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
    return blockHeight.toString();
  }

  static Future<AgentFactory> prepareAgent(Wallet? wallet) async {
    ICPSigner signer = ICPSigner.fromPhrase(wallet?.mnomenic ?? '',
        passphase: wallet?.password ?? '');
    return await AgentFactory.createAgent(
        canisterId: "ryjl3-tyaaa-aaaaa-aaaba-cai",
        // local ledger canister id, should change accourdingly
        url: "https://boundary.ic0.app/",
        // For Android emulator, please use 10.0.2.2 as endpoint
        idl: ledgerIdl,
        identity: signer.account.ecIdentity,
        debug: true);
  }
}
