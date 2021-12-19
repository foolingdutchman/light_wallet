import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_nft_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';
import 'package:flutter_light_wallet/view/nft/make_nft_page.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class NftCreatorPage extends StatefulWidget {
  const NftCreatorPage({Key? key}) : super(key: key);

  @override
  _NftCreatorPageState createState() =>
      _NftCreatorPageState("nft-creator-page-detector");
}

class _NftCreatorPageState extends BaseNftPageState<NftCreatorPage> {
  _NftCreatorPageState(String observerKey) : super(observerKey);

  String _space = "";
  String _principal = "";
  bool isCreator = false;

  @override
  Widget constructView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 80, left: 30, right: 30),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                S.of(context).spawnCreator,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 10),
              child: Text(
                S.of(context).current_remaining_canister_space,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                "$_space KB",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      S.of(context).creator_principal,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(
                      "$_principal",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              S.of(context).important_notice,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                S.of(context).copyright_declearation,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: ElevatedButton(
                onPressed: () {
                  if (_principal == "")
                    _spawnCreator();
                  else
                    Navigator.pushReplacement(
                        context, SlideRightRoute(page: MakeNftPage()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: Center(
                      child: Text(
                    _principal == ""
                        ? S.of(context).spawnCreator
                        : S.of(context).make_nft,
                    style: TextStyle(fontSize: 16),
                  )),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xfff3ab39)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _spawnCreator() async {
    if (isCanisterInit) {
      SmartDialog.showLoading();
      _principal = await walletCanister!.spawnCreator();

      setState(() {});
      SmartDialog.dismiss();
    }
  }

  @override
  void hanldEvent(Event event) {}

  @override
  void afterCaniterInted() {
    _getCanisterRemainSpace();
    _checkCreator();
  }

  void _getCanisterRemainSpace() async {
    SmartDialog.showLoading();
    var space = await walletCanister!.getCanisterRemainSpace();

    setState(() {
      _space = StringUtil.getNumberFormatStr(space);

    });
    SmartDialog.dismiss();
  }

  void  _checkCreator() async{
    isCreator = await walletCanister!.isNFTCreator();
    setState(() {
      _principal= isCreator? InstanceStore.currentWallet!.principal.toString():"";
    });
  }
}
