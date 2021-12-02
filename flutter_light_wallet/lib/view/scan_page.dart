import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/utils/image_util.dart';
import 'package:scan/scan.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  ScanController _controller = ScanController();
  bool _isFlashOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ScanView(
              controller: _controller,
              scanAreaScale: .7,
              scanLineColor: Color(0xFF4759DA),
              onCapture: (String data) {
                setResult(context, data);
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              Expanded(
                child: Container(),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(bottom: 80, left: 80, right: 80),
                child: Row(children: [
                  InkWell(
                    onTap: () {
                      _toggleFlash();
                    },
                    child: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white, size: 40),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {
                      _selectCodeImage(context);
                    },
                    child: Icon(
                      Icons.collections,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ]),
              ),
            ]),
          )
        ],
      ),
    );
  }

  void _toggleFlash() {
    _controller.toggleTorchMode();
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
  }

  void _selectCodeImage(BuildContext context) async {
    AssetEntity? assetEntity = await ImageUtil.pickImage(context);
    File? file = await assetEntity!.file;
    String path = file?.path ?? "";
    if (path != "") {
      String? result = await Scan.parse(path);
      if (result != null) {
        setResult(context, result);
      }
      print("result is : " + result! ?? "");
    }
  }

  setResult(BuildContext context, String result) {
    Navigator.pop(context, result);
  }
}
