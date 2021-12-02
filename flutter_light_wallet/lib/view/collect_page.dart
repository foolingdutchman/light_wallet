import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_light_wallet/base/base_page_state.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/model/wallet.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/string_util.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';

class CollectPage extends StatefulWidget {
  const CollectPage({Key? key}) : super(key: key);

  @override
  _CollectPageState createState() =>
      _CollectPageState('collect-page-decotetor');
}

class _CollectPageState extends BasePageState<CollectPage> {
  _CollectPageState(String observerKey) : super(observerKey);

  GlobalKey _globalKey = GlobalKey();

  @override
  Widget constructView(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(240, 255, 255, 255),
      body: Container(
        padding: EdgeInsets.only(top: 80, right: 30, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).collect,
              style: TextStyle(
                fontSize: 30,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: RepaintBoundary(
                key: _globalKey,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: QrImage(
                    data: InstanceStore.currentWallet!.address,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () =>
                          addressCopy(context, InstanceStore.currentWallet!),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Text(
                          InstanceStore.currentWallet!.address,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            ElevatedButton(
                onPressed: () {
                  _captureImage();
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 60,
                  child: Center(
                    child: Text(S.of(context).save_2d_code),
                  ),
                ),
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Color(0xffe4542a)),
              ),),

          ],
        ),
      ),
    );
  }

  void _captureImage() async {
    SmartDialog.showLoading();
    RenderRepaintBoundary boundary =
        _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3);
    ByteData? data = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List bytes = data!.buffer.asUint8List();
    var result = await ImageGallerySaver.saveImage(bytes,
        quality: 60, name: "address-qr-code");
    SmartDialog.dismiss();
    StringUtil.showToast( result["isSuccess"]?S.current.hint_save_code_success:S.current.hint_save_code_failded);
  }

  @override
  void hanldEvent(Event event) {
    // TODO: implement hanldEvent
  }

  @override
  void onFirstVisible() {
    // TODO: implement onFirstVisible
  }

  @override
  void onVisible() {
    // TODO: implement onVisible
  }

  void addressCopy(BuildContext context, Wallet wallet) {
    print(" copy clicked!");
    StringUtil.copyTexttoClipboard(wallet.address);
  }
}
