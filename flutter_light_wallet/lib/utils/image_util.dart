
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
class ImageUtil {
  
  static Future<AssetEntity?> pickImage(BuildContext context) async {

    
    AssetEntity? asset;
    List<AssetEntity>? assets =
        await AssetPicker.pickAssets(context);
    if (assets!.length!= 0) {
      if (isAssetImage(assets[0])) {
        asset = assets[0];
      }
    }
    return asset;
  }

  static bool isAssetImage(AssetEntity asset) {
    return asset.mimeType == 'image/jpeg' || asset.mimeType == 'image/png';
  }
 
 static Future<Uint8List> getThumbnailData(Uint8List list) async{
   var result = await FlutterImageCompress.compressWithList(
     list,
     minHeight: 800,
     minWidth: 600,
     quality: 40,
   );
   print(list.length);
   print(result.length);
   return result;
 }



}


