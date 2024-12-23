import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class FileUtil {
  static File getFileByPath(String path) {
    File file = new File(path);
    return file;
  }

  static Future<Uint8List> readFiletoByte(String path) async {
    File file = new File(path);
    return file.readAsBytes();
  }

  static Future<String> base64String(File file) async {
    Uint8List data = await file.readAsBytes();
    return base64Encode(data);
  }

  static Future<File> writeBytestoFile(
    String name,
    String filetype,
    Uint8List bytes,
  ) async {
    String _localPath = await getApplicationDocumentsDir();
    File file = File(_localPath + '/' + name + "." + filetype);
    bool isFileExist = await file.exists();
    if (!isFileExist) {
      file = await file.writeAsBytes(bytes);
    }
    return file;
  }

  static Future<File?> getFileByName(String name,
      String filetype) async{
    String _localPath = await getApplicationDocumentsDir();
    File file = File(_localPath + '/' + name + "." + filetype);
    bool isFileExist = await file.exists();
    if(isFileExist) return file;
    return null;

  }

  static Future<String> getApplicationDocumentsDir() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    return appDocPath;
  }
}
