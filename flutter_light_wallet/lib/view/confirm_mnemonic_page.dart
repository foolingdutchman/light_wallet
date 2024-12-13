import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';

class ConfirmMnemonicPage extends StatefulWidget {
  const ConfirmMnemonicPage({Key? key, required this.mnemonic})
      : super(key: key);
  final String mnemonic;
  @override
  _ConfirmMnemonicPageState createState() =>
      _ConfirmMnemonicPageState(mnemonic: this.mnemonic);
}

class _ConfirmMnemonicPageState extends State<ConfirmMnemonicPage> {
  _ConfirmMnemonicPageState({required this.mnemonic});
  final String mnemonic;
  List<String> _words = [];
  List<String> _unSelectedWords = [];
  String _helpText = '';
  final List<Widget> _labels = [];
  final List<Widget> _clickLabels = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                S.of(context).confirm_mnemonic,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 40,
                height: 210,
                child: Wrap(spacing: 10, runSpacing: 30, children: _labels)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).select_mnemonic_words,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
            ),
            Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 40,
                height: 210,
                child:
                    Wrap(spacing: 10, runSpacing: 30, children: _clickLabels)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$_helpText',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(
                      Size(MediaQuery.of(context).size.width - 50, 50)),
                ),
                onPressed: confirMnemonic,
                child: Text(S.of(context).confirm)),
          ],
        ),
      ),
    );
  }

  void confirMnemonic() {
    String s = _words.join(" ");
    if (s == mnemonic) {
      Navigator.pop(context, "OK");
    } else
      setState(() {
        this._helpText =S.current.wrong_mnemonic_words_sequences;
      });
  }

  @override
  void initState() {
    _unSelectedWords = mnemonic.split(" ");
    _unSelectedWords.shuffle();
    List<Widget> list = _renderLabels(_unSelectedWords, (int position) {
      _renderSelectLabels(position);
      //print("clicked position is " + position.toString());
    }, Colors.blueGrey.shade50);
    super.initState();
    if (list.isNotEmpty) {
      setState(() {
        _clickLabels.clear();
        _clickLabels.addAll(list);
      });
    }
  }

  void _renderUnSelectLabels(int position) {
    _unSelectedWords.add(_words[position]);
    _words.removeAt(position);
    renderViews();
  }

  void renderViews() {
    List<Widget> selected =
        _renderLabels(_words, _renderUnSelectLabels, Colors.white);
    List<Widget> unSelected = _renderLabels(
        _unSelectedWords, _renderSelectLabels, Colors.blueGrey.shade50);
    setState(() {
      this._helpText = '';
      this._labels.clear();
      this._labels.addAll(selected);
      this._clickLabels.clear();
      this._clickLabels.addAll(unSelected);
    });
  }

  void _renderSelectLabels(int position) {
    _words.add(_unSelectedWords[position]);
    _unSelectedWords.removeAt(position);
    renderViews();
  }

  List<Widget> _renderLabels(
      List<String> words, clickHandler, Color labelColor) {
    List<Widget> views = [];
    for (var i = 0; i < words.length; i++) {
      var label = InkWell(
        onTap: () => clickHandler(i),
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: labelColor,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Text(
            words[i],
            style: TextStyle(fontSize: 15),
          ),
        ),
      );
      views.add(label);
    }
    return views;
  }
}
