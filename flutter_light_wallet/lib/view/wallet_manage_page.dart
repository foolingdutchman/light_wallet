
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';

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
                '钱包管理',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              '地址',
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
                  child: Text(wallet.address,
                      style: TextStyle(color: Colors.black54)),
                ),
              ),
            ),
            Text(
              'Pricinpal',
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
                      StringUtil.showToast('已将当前钱包设为默认钱包');
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 60,
                      child: Center(
                        child: Text('设置为默认钱包'),
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
                                ? '设置手势密码'
                                : '修改手势密码'),
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
                      child: Text('导出助记词'),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                  onPressed: () {
                    InstanceStore.removeWallet(wallet);
                    EventBusUtil.fire(DeleteWalletEvent(wallet));
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 60,
                    child: Center(
                      child: Text('删除钱包'),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
