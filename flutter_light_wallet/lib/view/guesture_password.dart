import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gesture_password_widget/widget/gesture_password_widget.dart';

class GuesturePasswordPage extends StatefulWidget {
  final String type;
  final Wallet? wallet;
  const GuesturePasswordPage({Key? key, required this.type, this.wallet})
      : super(key: key);

  @override
  _GuesturePasswordPageState createState() =>
      _GuesturePasswordPageState(this.type, wallet: this.wallet);
}

class _GuesturePasswordPageState extends State<GuesturePasswordPage> {
  _GuesturePasswordPageState(this.type, {this.wallet});
  String type;
  Wallet? wallet;
  String _result = '';
  List<int> _temp = [];
  bool isPasswordVerified = false;
  final int MAX_WRONG_TIME = 5;
  int wrongtime = 0;
  static const backgroundColor = Color(0xff252534);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 150.0, bottom: 10.0),
              child: Text(
                type == 'create_password'
                    ? S.of(context).set_guesture_password
                    : S.of(context).input_guesture_password,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              height: 80,
              child: Text(
                _result,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.red,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: createXiMiGesturePasswordView(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget createXiMiGesturePasswordView() {
    return GesturePasswordWidget(
      lineColor: Colors.white,
      errorLineColor: Colors.redAccent,
      singleLineCount: 3,
      identifySize: 80.0,
      minLength: 4,
      hitShowMilliseconds: 40,
      errorItem: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      normalItem: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      selectedItem: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      hitItem: Container(
        width: 15.0,
        height: 15.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      answer: type == 'create_password'
          ? _temp
          : StringUtil.getIntListFromString(wallet!.guesturePassword),
      color: backgroundColor,
      onComplete: (data) {
        print('answer is : ' + _temp.join(','));

        switch (type) {
          case 'create_password':
            if (_temp.length == 0) {
              for (var i = 0; i < data.length; i++) {
                _temp.add(data[i] ?? -1);
              }
              print('result is : ' + _temp.join(', '));
              setState(() {
                _result = S.of(context).repeat_guesture_password;
              });
            } else if (_temp.join(',') == data.join(',')) {
              _savePassword(data.join(','));
            } else {
              wrongtime++;
              if (wrongtime < 5) {
                setState(() {
                  _result = S.of(context).wrong_guesture_password_hint(
                      (MAX_WRONG_TIME - wrongtime).toString());
                });
              } else {
                Navigator.pop(context);
              }
            }
            break;
          case 'modify_password':
            if (!isPasswordVerified) {
              if (wallet!.guesturePassword == data.join(','))
                setState(() {
                  _result =S.of(context).new_guesture_password;
                  isPasswordVerified = true;
                });
              else {
                wrongtime++;
                if (wrongtime < 5) {
                  setState(() {
                    _result = S.of(context).wrong_guesture_password_hint(
                        (MAX_WRONG_TIME - wrongtime).toString());
                  });
                } else {
                  Navigator.pop(context);
                }
              }
            } else {
              if (_temp.length == 0) {
                for (var i = 0; i < data.length; i++) {
                  _temp.add(data[i] ?? -1);
                }
                print('result is : ' + _temp.join(', '));
                setState(() {
                  _result =S.of(context).repeat_guesture_password;
                });
              } else if (_temp.join(',') == data.join(',')) {
                _savePassword(data.join(','));
              } else {
                wrongtime++;
                if (wrongtime < MAX_WRONG_TIME) {
                  setState(() {
                    _result = S.of(context).wrong_guesture_password_hint(
                        (MAX_WRONG_TIME - wrongtime).toString());
                  });
                } else {
                  Navigator.pop(context);
                }
              }
            }

            break;
          case 'verify_password':
            if (wallet!.guesturePassword == data.join(','))
              Navigator.pop(context, 'OK');
            else {
              wrongtime++;
              if (wrongtime < MAX_WRONG_TIME) {
                setState(() {
                  _result = S.of(context).wrong_guesture_password_hint(
                      (MAX_WRONG_TIME - wrongtime).toString());
                });
              } else {
                Navigator.pop(context);
              }
            }
            break;
          default:
        }
      },
    );
  }

  _savePassword(String password) async {
    wallet!.guesturePassword = password;
    SmartDialog.showLoading();
    await InstanceStore.saveCurrentDeviceInfo();
    // InstanceStore.updateCurrentWallet();
    await InstanceStore.updateHiveDB();
    SmartDialog.dismiss();
    StringUtil.showToast(S.current.guesture_password_settled);
    Navigator.pop(context, 'OK');
  }
}
