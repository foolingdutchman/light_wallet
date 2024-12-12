import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_nft_page_state.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/file_util.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class NftMetaPage extends StatefulWidget {
  const NftMetaPage({Key? key, required this.nft}) : super(key: key);
  final NftData nft;

  @override
  _NftMetaPageState createState() => _NftMetaPageState(this.nft);
}

class _NftMetaPageState extends BaseNftPageState<NftMetaPage> {
  NftData? nftData;
  File? image;

  _NftMetaPageState(this.nftData) : super('nft-meta-page-detector');

  @override
  Widget constructView(BuildContext context) {
    // TODO: implement constructView
    return Container(
      color: Colors.black87,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: image == null
          ? Container()
          : ExtendedImage.file(
              image!,
              fit: BoxFit.contain,
              mode: ExtendedImageMode.gesture,
              initGestureConfigHandler: (state) {
                return GestureConfig(
                  minScale: 0.9,
                  animationMinScale: 0.7,
                  maxScale: 3.0,
                  animationMaxScale: 3.5,
                  speed: 1.0,
                  inertialSpeed: 100.0,
                  initialScale: 1.0,
                  inPageView: false,
                  initialAlignment: InitialAlignment.center,
                );
              },
            ),
    );
  }

  _getImageFile() async {
    print("get image ....");
    image = await FileUtil.getFileByName(
        nftData!.principal.toString(), nftData!.mediaType);
    if (image == null) {
      print("downloading image ....");
      SmartDialog.showLoading();
      Uint8List? bytes =
          await walletCanister!.getNftMeta(nftData!.principal.toString());
      SmartDialog.dismiss();
      print("image downloaded ....");
      image = await FileUtil.writeBytestoFile(
          nftData!.principal.toString(), nftData!.mediaType, bytes!);
      setState(() {});
        } else {
      print(" image found ....");
      setState(() {});
    }
  }

  @override
  void hanldEvent(Event event) {
    // TODO: implement hanldEvent
  }


  @override
  void afterCaniterInted() {
    print(" afterCaniterInted ....");
    _getImageFile();
  }
}
