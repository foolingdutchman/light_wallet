
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';

class MnemonicPage extends StatefulWidget {
  const MnemonicPage({Key? key, required this.mnemonic}) : super(key: key);
  final String mnemonic;

  @override
  _MnemonicPageState createState() =>
      _MnemonicPageState(mnemonic: this.mnemonic);
}

class _MnemonicPageState extends State<MnemonicPage> {
  String mnemonic;
  List<String> _words = [];
  _MnemonicPageState({required this.mnemonic});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 80,left: 30,right: 30),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              S.of(context).save_mnemonic,
              style: TextStyle(
                 fontSize: 30,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
                width: MediaQuery.of(context).size.width - 36,
                height: 325,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.separated(
                        itemBuilder: (context, postion) {
                          return Row(
                            children: [
                              Expanded(
                                  child: Container(
                                height: 80,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Center(
                                      child: Text(_words[3 * postion]),
                                    )),
                                    Container(
                                      color: Colors.black26,
                                      width: 1,
                                      height: 80,
                                    )
                                  ],
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                height: 80,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Center(
                                      child: Text(_words[3 * postion + 1]),
                                    )),
                                    Container(
                                      color: Colors.black26,
                                      width: 1,
                                      height: 80,
                                    )
                                  ],
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                height: 80,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Center(
                                      child: Text(_words[3 * postion + 2]),
                                    )),
                                  ],
                                ),
                              )),
                            ],
                          );
                        },
                        separatorBuilder: (c, i) => new Container(
                              width: MediaQuery.of(context).size.width - 38,
                              height: 1,
                              color: Colors.black26,
                            ),
                        itemCount: _words.length ~/ 3))),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width - 50, 50)),
                ),
                onPressed: () {
                  StringUtil.copyTexttoClipboard(mnemonic);
                },
                child: Text(S.of(context).copy_mnemonic)),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width - 50, 50)),
                ),
                onPressed: () {
                  Navigator.pop(context, 'OK');
                },
                child: Text(S.of(context).comfirm_mnemonic_backup))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    var words = mnemonic.split(' ');
    super.initState();
    if (words.isNotEmpty) {
      setState(() {
        _words.clear();
        _words.addAll(words);
      });
    }
  }
}
