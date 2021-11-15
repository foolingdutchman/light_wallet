import 'package:agent_dart/agent_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/rosetta_utils.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'password_page.dart';
import 'app_page.dart';
import 'import_wallet_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState('my-splash-key');
}

class _HomePageState extends BasePageState<HomePage>
    with WidgetsBindingObserver {
  // setup state class variable;
  bool _showRegisterButton = false;
  bool isFirstVisible = true;

  _HomePageState(String observerKey) : super(observerKey);

  void onCreatePressed() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return PasswordPage(type: 'create_wallet');
    }));
  }

  void onImportPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return ImportWalletPage();
    }));
  }

  @override
  void initState() {
    // _checkWalletInfo();
    super.initState();
  }

  void onFirstVisible() {
    _checkWalletInfo();
  }

  void onVisible() {
    _checkWalletInfo();
  }

  Future<void> _checkWalletInfo() async {
    if (!InstanceStore.isStoreInit) {
      await InstanceStore.init();
    }
    if (InstanceStore.currentWallet != null) {
      SmartDialog.showLoading();
      Wallet? currentWallet = InstanceStore.currentWallet;
      print("wallet info: \n" +
          " wallet principal is " +
          currentWallet!.principal +
          '\n address is : ' +
          currentWallet.address);

      _checkSigner(currentWallet);
      if (!RosettaUtils.isInit) {
        await RosettaUtils.init();
      }
      SmartDialog.dismiss();
      // go to home page
      Navigator.pushReplacement(
          context, SlideRightRoute(page: AppPage(title: 'Icp wallet')));
      //Navigator.pop(context);
    } else {
      setState(() {
        _showRegisterButton = true;
      });
    }
  }

  void _checkSigner(Wallet wallet) {
    ICPSigner signer =
        ICPSigner.fromPhrase(wallet.mnomenic, passphase: wallet.password);
    String signerecPricinpal =
        signer.account.identity?.getPrincipal().toString() ?? '';
    String signerecKey = signer.account.ecKeys?.ecPrivateKey?.toHex() ?? '';
    String signerecChecksumAddress = signer.ecChecksumAddress ?? '';

    print('ICP ACCOUNT INFO: \n signerecPricinpal : ' +
        signerecPricinpal +
        " \n signerecKey : " +
        signerecKey +
        " \n signerecChecksumAddress is : " +
        signerecChecksumAddress);
  }

  @override
  Widget constructView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Container(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg_logo.png'))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: _showRegisterButton
                  ? Column(
                      children: [
                        ElevatedButton(
                          onPressed: onCreatePressed,
                          child: Text(S.of(context).create_wallet),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(
                                MediaQuery.of(context).size.width - 50, 50)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: onImportPressed,
                          child: Text(S.of(context).import_wallet),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(
                                MediaQuery.of(context).size.width - 50, 50)),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 30,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void hanldEvent(Event event) {
    // TODO: implement hanldEvent
  }
}
