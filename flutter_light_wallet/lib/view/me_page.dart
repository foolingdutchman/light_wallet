
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/icp_account_utils.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'password_page.dart';
import 'import_wallet_page.dart';


class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  _MePageState createState() => _MePageState('ma-page-detector');
}

class _MePageState extends BasePageState<MePage> {
  List<Wallet> _items = [];
  bool isFirstVisible = true;

  _MePageState(String observerKey) : super(observerKey);

  @override
  Widget constructView(BuildContext context) {
    {
      return Scaffold(
        backgroundColor: Colors.white70,
        body: Container(
          padding: const EdgeInsets.only(top: 80.0, left: 30.0, right: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    S.of(context).mine,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () => _onSettingClick(),
                      child: Container(
                        child: Icon(Icons.settings,
                            size: 28, color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                      itemCount: _items.length + 1,
                      itemBuilder: (context, position) {
                        return position < _items.length
                            ? generateWalletView(_items[position], position)
                            : Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    InkWell(
                                      onTap: () =>
                                          _onCreateWalletClick(context),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 0.5),
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(5, 5),
                                                  blurRadius: 10,
                                                  color: Colors.black12),
                                            ]),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 100,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Expanded(child: Container()),
                                              Icon(Icons.add,
                                                  size: 25,
                                                  color: Colors.black26),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  S.of(context).add_wallet,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black26),
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    )
                                  ],
                                ),
                              );
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    _items = InstanceStore.walletLists;
    super.initState();
  }

  @override
  void hanldEvent(Event event) {
    if (event is DeleteWalletEvent ||
        event is SwitchWalletEvent ||
        event is NewWalletEvent) {
      print('***************event recogonized!');
      setState(() {
        _items = InstanceStore.walletLists;
      });
    } else if (event is ClearWalletEvent) {
      // Navigator.pop(context);
    }
  }

  @override
  void onFirstVisible() {}

  @override
  void onVisible() {}

  void _onCreateWalletClick(BuildContext context) {
    print('create wallet clicked! ');

    SmartDialog.show(
        widget: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: 160,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(5, 5),
                    blurRadius: 10,
                    color: Colors.black12),
              ]),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    SmartDialog.dismiss();
                    _creatNewWallet();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 100,
                    child: Center(child: Text(S.of(context).create_wallet)),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                    onPressed: () {
                      SmartDialog.dismiss();
                      _importWallet();
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 100,
                      child: Center(child: Text(S.of(context).import_wallet)),
                    )),
              ),
            ],
          ),
        ),
        isLoadingTemp: false);
  }

  void _creatNewWallet() {
    Navigator.push(
        context, SlideRightRoute(page: PasswordPage(type: 'create_wallet')));
  }

  void _importWallet() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String filePath =result.files.single.path??"";
      ICPAccountUtils.importPemWallet(filePath);
    } else {
      // User canceled the picker
    }


    // Navigator.push(context, SlideRightRoute(page: ImportWalletPage()));
  }

  void _onSettingClick() {
    Navigator.push(context, SlideRightRoute(page: SettingPage()));
  }

  void pricinpalCopy(BuildContext context, Wallet wallet) {
    print(" copy clicked!");
    StringUtil.copyTexttoClipboard(wallet.principal);
  }

  void addressCopy(BuildContext context, Wallet wallet) {
    print(" copy clicked!");
    StringUtil.copyTexttoClipboard(wallet.address);
  }

  Widget generateWalletView(Wallet wallet, int position) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(position == 0 ? 0xfff3ab39 : 0x66f3ab39),
                    Color(position == 0 ? 0xffe4542a : 0x66e4542a),
                    Color(position == 0 ? 0xffe91f6f : 0x66e91f6f),
                    Color(position == 0 ? 0xff39267e : 0x6639267e),
                    Color(position == 0 ? 0xff27a1e4 : 0x6627a1e4),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(5, 5),
                      blurRadius: 10,
                      color: Colors.black26),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.pricinpal_id,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          wallet.principal,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10, color: Colors.white70),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: InkWell(
                          onTap: () => pricinpalCopy(context, wallet),
                          child: Container(
                            child: Icon(
                              Icons.copy,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  S.current.address,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          wallet.address,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10, color: Colors.white70),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: InkWell(
                          onTap: () => addressCopy(context, wallet),
                          child: Container(
                            child: Icon(
                              Icons.copy,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5, top: 2, bottom: 2),
                      child: InkWell(
                        onTap: () => walletManage(_items[position]),
                        child: Container(
                          child: Text(
                            S.current.manage,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void walletManage(Wallet wallet) {
    Navigator.push(
        context, SlideRightRoute(page: WalletMangementPage(wallet: wallet)));
  }
}
