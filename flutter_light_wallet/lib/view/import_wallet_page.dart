
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';

import 'password_page.dart';

class ImportWalletPage extends StatefulWidget {
  const ImportWalletPage({Key? key}) : super(key: key);

  @override
  _ImportWalletPageState createState() =>
      _ImportWalletPageState('import-wallet-detector');
}

class _ImportWalletPageState extends BasePageState<ImportWalletPage> {
  _ImportWalletPageState(String observerKey) : super(observerKey);
  String _helptext = '';
  TextEditingController _mnemonicsController = TextEditingController();

  @override
  Widget constructView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 80, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).import_mnemonic,
              style: TextStyle(
                fontSize: 30,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50, top: 50),
              child: TextField(
                decoration: InputDecoration(
                  labelText:S.of(context).input_mnemonic,
                  labelStyle: TextStyle(
                    color: Colors.pink,
                    fontSize: 12,
                  ),
                  helperText: '$_helptext',
                  helperStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 12,
                  ),
                  hintText: S.of(context).input_mnemonic,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink,
                    ),
                  ),
                ),
                controller: _mnemonicsController,
                onChanged: (text) {
                  setState(() {
                    _helptext = '';
                  });
                },
              ),
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
                      child: Text(S.of(context).confirm_import_mnemonic),
                      onPressed: () {
                        if (_checkMnemonicValid()) {
                          Navigator.pushReplacement(
                              context,
                              SlideRightRoute(
                                  page: PasswordPage(
                                type: 'import_wallet',
                                mnemonic: _mnemonicsController.text,
                              )));
                        } else {
                          setState(() {
                            _helptext =S.of(context).wrong_mnemonic_words_sequences;
                          });
                        }
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void hanldEvent(Event event) {}

  @override
  void onFirstVisible() {}

  @override
  void onVisible() {}

  bool _checkMnemonicValid() {
    return true;
    return _mnemonicsController.text.split(' ').length == 12;
  }
}
