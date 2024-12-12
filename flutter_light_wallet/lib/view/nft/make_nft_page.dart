import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_nft_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/Instance_store.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:agent_dart/agent_dart.dart';
import 'package:flutter_light_wallet/utils/image_util.dart';
import 'package:flutter_light_wallet/utils/icp_account_utils.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';
import 'package:flutter_light_wallet/utils/time_util.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'invoice_page.dart';

class MakeNftPage extends StatefulWidget {
  const MakeNftPage({Key? key}) : super(key: key);

  @override
  _MakeNftPageState createState() => _MakeNftPageState('canister-page-key');
}

class _MakeNftPageState extends BaseNftPageState<MakeNftPage> {
  _MakeNftPageState(String observerKey) : super(observerKey);

  AssetEntity? asset;
  TextEditingController _authorController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  String _helptext = "";
  FocusNode _descFusNode = FocusNode();
  bool _isDescFocus = false;
  BigInt cost =BigInt.zero;
  String price ="0";
  String principalStr ="";


  @override
  Widget constructView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 80, left: 30, right: 30),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        S.of(context).make_nft,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, bottom: 5),
                      child: Text(
                        S.of(context).input_author,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: S.of(context).input_author,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pink,
                            ),
                          ),
                        ),
                        controller: _authorController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 30, left: 30, right: 30, bottom: 5),
                      child: Text(
                        S.of(context).input_title,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: S.of(context).input_title,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pink,
                            ),
                          ),
                        ),
                        controller: _titleController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 30, left: 30, right: 30, bottom: 5),
                      child: Text(
                        S.of(context).input_desc,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 30),
                      child: Container(
                        height: 120,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _isDescFocus ? Colors.blue : Colors.black26,
                            width: _isDescFocus ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                focusNode: _descFusNode,
                                maxLines: 10,
                                maxLength: 500,
                                decoration: InputDecoration(
                                  hintText: S.of(context).input_desc,
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                ),
                                controller: _descController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _selectImage(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 120,
                            height: MediaQuery.of(context).size.width - 120,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 0.5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(5, 5),
                                    blurRadius: 10,
                                    color: Colors.black26),
                              ],
                            ),
                            child: Center(
                              child: asset == null
                                  ? Column(
                                      children: [
                                        Expanded(
                                          child: Container(),
                                          flex: 2,
                                        ),
                                        Icon(
                                          Icons.add,
                                          size: 80,
                                          color: Colors.black26,
                                        ),
                                        Text(
                                          S.of(context).select_your_art,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black26,
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(),
                                          flex: 3,
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: Image(
                                        image: AssetEntityImageProvider(asset!,
                                            isOriginal: false),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                118,
                                        height:
                                            MediaQuery.of(context).size.width -
                                                118,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30, top: 15 ),
                      child: Text(
                        S.of(context).mint_cost+ ": $price ICP" ,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 30, right: 30),
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, -3),
                      blurRadius: 3,
                      color: Colors.black26),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(S.of(context).balance + ":"),
                  ),
                  Expanded(
                    child: Text(InstanceStore.currentWallet!
                            .getICPBalance()
                            .toString() +
                        " ICP"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                       // _mintNft(context);
                        _getMintInvoice(context);
                      },
                      child: Text(S.of(context).make_nft)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _descFusNode.addListener(() {
      setState(() {
        _isDescFocus = _descFusNode.hasFocus;
      });
    });
    AssetPicker.registerObserve();
  }

  @override
  void dispose() {
    super.dispose();
    AssetPicker.unregisterObserve(); // Unregister callback.
  }

  @override
  void hanldEvent(Event event) {
    if( event is MintNftEvent){
      final current = ModalRoute.of(context);
      Navigator.removeRoute(context, current!);
    }
  }

  _createPrincipal(context) {
    Principal principal =
        ICPAccountUtils.createPrincipal(TimeUtil.currentTImeMillis().toU8a());
    print('principal :' + principal.toString());
  }

  _selectImage(BuildContext context) async {
    
    asset = await ImageUtil.pickImage(context);
    if (asset != null) {
      setState(() {});
      _getMintPrice();
    }
    
  }

  _getMintPrice() async{
    if(isCanisterInit&& asset != null ){
      SmartDialog.showLoading();
      File? file =await asset!.file;


      var size = await file?.length();
      cost = await walletCanister!.getMintPrice(size!);
      SmartDialog.dismiss();
      setState(() {
        price = getMintPriceString();
      });
    }
  }

  String getMintPriceString(){
   return (cost / BigInt.from(100000000)).toString();
  }

  _getMintInvoice(BuildContext context) async{

    if(!_isDataPrepared()){
      SmartDialog.showToast(S.of(context).data_not_ready);
      return;
    }

    if(!checkBlanceValid()){
      SmartDialog.showToast(S.of(context).hint_icp_not_enough);
      return;
    }

    if(isCanisterInit&& asset != null ){
      SmartDialog.showLoading();
      if(principalStr.isEmpty) principalStr =ICPAccountUtils.createTempPrincipalString();
      File? file =await asset!.file;
      var size = await file!.length();
      Invoice? invoice =   await walletCanister!.claimMintInvoice(principalStr, size);
      SmartDialog.dismiss();
      if(invoice !=null){
        List<BigInt> blockHeight= await  Navigator.push(context, SlideRightRoute(page: InvoicePage(invoiceData: invoice)));
        PostNftData nftData = await _prepareNftData(invoice, blockHeight[0]);
        await _mintNft(context,nftData);

      }
    }
  }

  bool checkBlanceValid(){
    return InstanceStore.currentWallet!.getICPBalance()>=  ICPAccountUtils.fromICPBigInt2Amount(cost)+ 0.0001;
  }

  bool _isDataPrepared(){
    if(_authorController.text.isEmpty) return false;
    if(_titleController.text.isEmpty) return false;
    if(_descController.text.isEmpty) return false;
    if(cost == BigInt.zero) return false;
    if(asset==null) return false;
    return true;
  }

  Future<PostNftData> _prepareNftData(Invoice invoice,BigInt blockHeight) async{

    File? file = await asset!.file;
    var data = await file!.readAsBytes();
    var thumbnail = await ImageUtil.getThumbnailData(data);
    var path = file.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    Map<String, dynamic> map ={
      'title': _titleController.text,
      'thumbnail': thumbnail,
      'desc': _descController.text,
      'author': _authorController.text,
      'isPrivate': false,
      'mediaType':suffix,
    };

    return PostNftData(map, data,invoice,blockHeight);
  }

  _mintNft(BuildContext context, PostNftData nftData) async {
    if (isCanisterInit && asset != null) {
      SmartDialog.showLoading();
      Invoice? invoice = await walletCanister!.mintNft(nftData);
      SmartDialog.dismiss();
      if (invoice!= null) {
        EventBusUtil.fire(MintNftEvent(invoice));
        Navigator.pushReplacement(
            context,
            SlideRightRoute(
                page: InvoicePage(
              invoiceData: invoice,
            )));
      }

    }
  }

  @override
  void afterCaniterInted() {}
}

class PostNftData{
  Map<String, dynamic>? map;
  Uint8List? meta;
  Invoice? invoice;
  BigInt? blockHeight;
  PostNftData(this.map, this.meta ,this.invoice, this.blockHeight);
}
