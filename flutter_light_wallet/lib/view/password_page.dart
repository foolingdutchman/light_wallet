import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/icp_account_utils.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';

import 'confirm_mnemonic_page.dart';
import 'mnemonic_page.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage(
      {Key? key, required this.type, this.password = '', this.mnemonic = ''})
      : super(key: key);
  final String type;
  final String password;
  final String mnemonic;

  @override
  _PasswordPageState createState() => _PasswordPageState(
      type: this.type, password: this.password, mnemonic: this.mnemonic);
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController _passwodController = TextEditingController();
  String _helptext = '';
  String _type = '';
  String _receivedPassword = '';
  String _mnemonic = '';
  bool _obscureText = true;
  _PasswordPageState(
      {required String type, String password = '', String mnemonic = ''}) {
    this._type = type;
    this._receivedPassword = password;
    this._mnemonic = mnemonic;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 80, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                _receivedPassword == '' ? '输入密码' : '再次输入密码',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 30),
              child: TextField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: _receivedPassword == '' ? '输入密码' : '再次输入密码',
                  labelStyle: TextStyle(
                    color: Colors.pink,
                    fontSize: 12,
                  ),
                  helperText: '$_helptext',
                  helperStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 12,
                  ),
                  hintText: '请输入密码',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink,
                    ),
                  ),
                ),
                controller: _passwodController,
                onChanged: _onTextChange,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width - 50, 50)),
                      ),
                      onPressed: () {
                        if (_passwodController.text.isEmpty) {
                          setState(() {
                            _helptext = '密码不能为空';
                          });
                        } else {
                          print('type is :' + _type);
                          switch (_type) {
                            case 'create_wallet':
                              print('tcreate wallet  is type ' + _type);
                              print('password  is :' + _passwodController.text);
                              Navigator.pushReplacement(
                                  context,
                                  SlideRightRoute(
                                      page: PasswordPage(
                                    type: 'create_wallet_password',
                                    password: _passwodController.text,
                                  )));
                              break;
                            case 'create_wallet_password':
                              if (_passwodController.text !=
                                  _receivedPassword) {
                                setState(() {
                                  _helptext = '密码输入不一致';
                                });
                              } else {
                                String mnemonic =
                                    ICPAccountUtils.generateBip39Mnemonic();
                                _showMnemonicForResult(context, mnemonic);
                              }
                              break;
                            case 'verify_password':
                              Wallet? wallet = InstanceStore.currentWallet;
                              if (wallet!.password == _passwodController.text) {
                                Navigator.pop(context, 'OK');
                              }
                              break;
                            case 'import_wallet':
                              Navigator.pushReplacement(
                                  context,
                                  SlideRightRoute(
                                      page: PasswordPage(
                                          type: 'import_wallet_password',
                                          password: _passwodController.text,
                                          mnemonic: _mnemonic)));
                              break;
                            case 'import_wallet_password':
                              if (_passwodController.text !=
                                  _receivedPassword) {
                                setState(() {
                                  _helptext = '密码输入不一致';
                                });
                              } else {
                                _generateAccount(_mnemonic, _receivedPassword);
                              }
                              break;
                          }
                        }
                      },
                      child: Text('确定')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmMnemonicForResult(BuildContext context, String mnemonic) async {
    final result = await Navigator.push(context,
        SlideRightRoute(page: ConfirmMnemonicPage(mnemonic: mnemonic)));
    if (result == 'OK') {
      _generateAccount(mnemonic, _receivedPassword);
    }
  }

  void _generateAccount(String mnemonic, String password) async {
    Wallet wallet = ICPAccountUtils.generateWallet(password, mnemonic);
    bool iscreate = await InstanceStore.createWallet(wallet);
    if (iscreate) {
      StringUtil.showToast('钱包已生成！');
      EventBusUtil.fire(NewWalletEvent(wallet));
    } else {
      StringUtil.showToast('本地已存在此钱包');
    }

    Navigator.pop(context);
  }

  void _showMnemonicForResult(BuildContext context, String mnemonic) async {
    final result = await Navigator.push(
        context, SlideRightRoute(page: MnemonicPage(mnemonic: mnemonic)));

    if (result == 'OK') {
      _confirmMnemonicForResult(context, mnemonic);
    }
  }

  void _onTextChange(s) {
    setState(() {
      _helptext = s.toString().isEmpty ? '密码不能为空' : '';
    });
  }

  void onButtonPressed() {}
}
