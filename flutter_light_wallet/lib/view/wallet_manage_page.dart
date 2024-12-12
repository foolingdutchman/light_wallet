import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';
import 'package:flutter_light_wallet/view/password_page.dart';

import 'guesture_password.dart';
import 'mnemonic_page.dart';

class WalletMangementPage extends StatefulWidget {
  final Wallet wallet;

  const WalletMangementPage({Key? key, required this.wallet}) : super(key: key);

  @override
  _WalletMangementPageState createState() => _WalletMangementPageState(wallet);
}

class _WalletMangementPageState extends State<WalletMangementPage> {
  Wallet wallet;
  _WalletMangementPageState(this.wallet);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                S.of(context).wallet_manage,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              S.of(context).address,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            InkWell(
              onTap: () {
                StringUtil.copyTexttoClipboard(wallet.address);
              },
              child: Container(
                height: 80,
                margin: EdgeInsets.only(bottom: 20, top: 20),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(wallet.address,
                      style: TextStyle(color: Colors.black54)),
                ),
              ),
            ),
            Text(
              S.of(context).pricinpal_id,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            InkWell(
              onTap: () {
                StringUtil.copyTexttoClipboard(wallet.principal);
              },
              child: Container(
                height: 80,
                margin: EdgeInsets.only(bottom: 20, top: 20),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    wallet.principal,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ),
            wallet.equals(InstanceStore.currentWallet)
                ? Container(
                    height: 0,
                  )
                : ElevatedButton(
                    onPressed: () {
                      InstanceStore.swithCurrentWallet(wallet);
                      EventBusUtil.fire(SwitchWalletEvent(wallet));
                      StringUtil.showToast(
                          S.of(context).select_default_wallet_hint);
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 60,
                      child: Center(
                        child: Text(S.of(context).select_as_default_wallet),
                      ),
                    )),
            !InstanceStore.deviceInfo!.isGuesturePrintPasswordActive
                ? Container(
                    height: 0,
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              SlideRightRoute(
                                  page: GuesturePasswordPage(
                                type: wallet.guesturePassword == ''
                                    ? 'create_password'
                                    : 'modify_password',
                                wallet: wallet,
                              )));
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 60,
                          child: Center(
                            child: Text(wallet.guesturePassword == ''
                                ? S.of(context).set_guesture_password
                                : S.of(context).modify_guesture_password),
                          ),
                        )),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        SlideRightRoute(
                            page: PasswordPage(
                          type: 'modify_password_verify',
                          wallet: wallet,
                        )));
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 60,
                    child: Center(
                      child: Text(S.of(context).modify_password),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        SlideRightRoute(
                            page: MnemonicPage(mnemonic: wallet.mnomenic)));
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 60,
                    child: Center(
                      child: Text(S.of(context).export_mnemonic),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                  onPressed: () {
                    _deleteClick();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 60,
                    child: Center(
                      child: Text(S.of(context).delete_wallet),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteClick() async {
    String result = await Navigator.push(
        context, SlideRightRoute(page: PasswordPage(type: 'verify_password')));

    if (result == 'OK') {
      InstanceStore.removeWallet(wallet);
      if (InstanceStore.walletLists.length != 0) {
        EventBusUtil.fire(DeleteWalletEvent(wallet));
      } else {
        EventBusUtil.fire(ClearWalletEvent());
      }
      Navigator.pop(context);
    }
  }
}
