import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'guesture_password.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isGuestureOn = false;
  bool _isFigurePrintOn = false;
  static final List<String> _titles = [S.current.activate_guester_password,S.current.version];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  S.of(context).settings,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(child: Container()),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, postion) => ListTile(
                        leading: Text(
                          _titles[postion],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: postion == _titles.length - 1
                            ? Text('1.0.0')
                            : Switch(
                                value: (postion == 0
                                    ? _isGuestureOn
                                    : _isFigurePrintOn),
                                onChanged: (swithed) {
                                  if (postion == 0) {
                                    _swithGuesturePassWord(swithed);
                                  } else {
                                    //  InstanceStore.deviceInfo!
                                    //      .isFigerPrintPasswordActive = swithed;
                                  }
                                }),
                      ),
                  separatorBuilder: (context, i) => new Divider(
                        height: 1,
                        color: Colors.black26,
                      ),
                  itemCount: _titles.length),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _swithGuesturePassWord(bool isOn) async {
    print(' swithched on: ' +
        isOn.toString() +
        '\n isGuesturePrintPasswordActive : ' +
        InstanceStore.deviceInfo!.isGuesturePrintPasswordActive.toString() +
        '\n gusture password :' +
        InstanceStore.currentWallet!.guesturePassword);
    if (isOn && InstanceStore.currentWallet!.guesturePassword == '') {
      String result = await Navigator.push(
          context,
          SlideRightRoute(
              page: GuesturePasswordPage(
            type: 'create_password',
            wallet: InstanceStore.currentWallet,
          )));
      if (result == 'OK') {
        InstanceStore.deviceInfo!.isGuesturePrintPasswordActive = isOn;
        _updateInfo();
      }
    } else {
      InstanceStore.deviceInfo!.isGuesturePrintPasswordActive = isOn;
      _updateInfo();
    }
  }

  Future<void> _updateInfo() async {
    SmartDialog.showLoading();
    await InstanceStore.saveCurrentDeviceInfo();
    SmartDialog.dismiss();
    setState(() {
      _isFigurePrintOn = InstanceStore.deviceInfo!.isFigerPrintPasswordActive;
      _isGuestureOn = InstanceStore.deviceInfo!.isGuesturePrintPasswordActive;
    });
  }

  @override
  void initState() {
    _isFigurePrintOn = InstanceStore.deviceInfo!.isFigerPrintPasswordActive;
    _isGuestureOn = InstanceStore.deviceInfo!.isGuesturePrintPasswordActive;
    super.initState();
  }
}
