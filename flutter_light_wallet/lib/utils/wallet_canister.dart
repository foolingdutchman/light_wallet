import 'dart:typed_data';
import 'package:agent_dart/agent_dart.dart';
import 'package:flutter_light_wallet/utils/icp_account_utils.dart';

class WalletCanisterProperty {
  // property name
  static const title = 'title';
  static const timeStamp = 'timeStamp';
  static const author = 'author';
  static const mediaType = 'mediaType';
  static const data = 'data';
  static const id = 'id';
  static const owner = 'owner';
  static const creater = 'creater';
  static const principal = 'principal';
  static const transferOwner = 'transferOwner';
  static const thumbnail = 'thumbnail';
  static const desc = 'desc';
  static const sellId = 'sellId';
  static const nftData = 'nftData';
  static const price = 'price';
}

class NftData {
  int? id;
  String author = "";
  String title = "";
  String desc = "";
  String mediaType = "";
  int? timeStamp;
  int? sellId;
  Uint8List? thumbnail;
  Principal? principal;
  Principal? owner;
  Principal? creater;

  NftData(
      int id,
      int timeStamp,
      int sellId,
      String author,
      String title,
      String desc,
      String mediaType,
      Uint8List? thumbnail,
      Principal? principal,
      Principal? owner,
      Principal? creater) {
    this.principal = principal;
    this.timeStamp = timeStamp;
    this.title = title;
    this.author = author;
    this.creater = creater;
    this.desc = desc;
    this.id = id;
    this.mediaType = mediaType;
    this.owner = owner;
    this.sellId = sellId;
    this.thumbnail = thumbnail;
  }

  static NftData transformData(Map map) {
    return NftData(
        map[WalletCanisterProperty.id].toInt(),
        map[WalletCanisterProperty.timeStamp].toInt(),
        map[WalletCanisterProperty.sellId].toInt(),
        map[WalletCanisterProperty.author],
        map[WalletCanisterProperty.title],
        map[WalletCanisterProperty.desc],
        map[WalletCanisterProperty.mediaType],
        Uint8List.fromList(map[WalletCanisterProperty.thumbnail].cast<int>()),
        map[WalletCanisterProperty.principal],
        map[WalletCanisterProperty.owner],
        map[WalletCanisterProperty.creater]);
  }
}

abstract class WalletCanisterMethod {
  /// use staic const as method name
  static const getCaller = "getCaller";
  static const greet = "greet";
  static const getNft = 'getNft';
  static const getNftAddress = 'getNftAddress';
  static const mintNft = 'mintNft';
  static const spawnCreator = 'spawnCreator';
  static const getPrincipal = 'getPrincipal';
  static const cancelOrder = 'cancelOrder';
  static const getNftMetaData = 'getNftMetaData';
  static const makeOrder = 'makeOrder';
  static const queryNfts = 'queryNfts';
  static const transferOwner = 'transferOwner';
  static const updateOrder = 'updateOrder';
  static const queryOrders = 'queryOrders';
  static const getRemainSpace = 'getRemainSpace';

  /// you can copy/paste from .dfx/local/canisters/counter/counter.did.js

  static final Result = IDL.Variant({'ok': IDL.Principal, 'err': IDL.Text});
  static final NftData = IDL.Record({
    WalletCanisterProperty.id: IDL.Nat,
    WalletCanisterProperty.title: IDL.Text,
    WalletCanisterProperty.creater: IDL.Principal,
    WalletCanisterProperty.principal: IDL.Principal,
    WalletCanisterProperty.thumbnail: IDL.Vec(IDL.Nat8),
    WalletCanisterProperty.owner: IDL.Principal,
    WalletCanisterProperty.timeStamp: IDL.Nat,
    WalletCanisterProperty.desc: IDL.Text,
    WalletCanisterProperty.sellId: IDL.Nat,
    WalletCanisterProperty.author: IDL.Text,
    WalletCanisterProperty.mediaType: IDL.Text,
  });

  static final Order = IDL.Record({
    WalletCanisterProperty.id: IDL.Nat,
    WalletCanisterProperty.principal: IDL.Principal,
    WalletCanisterProperty.nftData: NftData,
    WalletCanisterProperty.price: IDL.Nat,
  });
  static final ServiceClass idl = IDL.Service({
    WalletCanisterMethod.cancelOrder: IDL.Func([IDL.Principal], [Result], []),
    WalletCanisterMethod.getCaller: IDL.Func([], [IDL.Text], []),
    WalletCanisterMethod.getNft:
        IDL.Func([IDL.Principal], [IDL.Opt(NftData)], ['query']),
    WalletCanisterMethod.getNftAddress:
        IDL.Func([IDL.Nat], [IDL.Opt(IDL.Principal)], ['query']),
    WalletCanisterMethod.getNftMetaData: IDL.Func(
      [IDL.Principal],
      [IDL.Opt(IDL.Vec(IDL.Nat8))],
      ['query'],
    ),
    WalletCanisterMethod.getPrincipal:
        IDL.Func([IDL.Text], [IDL.Principal], []),
    WalletCanisterMethod.getRemainSpace: IDL.Func([], [IDL.Nat], []),
    WalletCanisterMethod.greet: IDL.Func([IDL.Text], [IDL.Text], []),
    WalletCanisterMethod.makeOrder:
        IDL.Func([IDL.Principal, IDL.Nat], [Result], []),
    WalletCanisterMethod.mintNft: IDL.Func(
      [
        IDL.Vec(IDL.Nat8),
        IDL.Text,
        IDL.Text,
        IDL.Text,
        IDL.Text,
        IDL.Nat,
        IDL.Text,
        IDL.Vec(IDL.Nat8),
      ],
      [Result],
      [],
    ),
    WalletCanisterMethod.queryNfts:
        IDL.Func([IDL.Nat], [IDL.Vec(NftData)], ['query']),
    WalletCanisterMethod.queryOrders:
        IDL.Func([IDL.Nat], [IDL.Vec(Order)], ['query']),
    WalletCanisterMethod.spawnCreator: IDL.Func([], [IDL.Text], []),
    WalletCanisterMethod.transferOwner:
        IDL.Func([IDL.Principal, IDL.Principal], [Result], []),
    WalletCanisterMethod.updateOrder:
        IDL.Func([IDL.Principal, IDL.Nat], [Result], []),
  });
}

class WalletCanister {
  /// AgentFactory is a factory method that creates Actor automatically.
  /// Save your strength, just use this template
  AgentFactory? _agentFactory;

  /// CanisterCator is the actor that make all the request to Smartcontract.
  CanisterActor? get actor => _agentFactory?.actor;
  final String canisterId;
  final String url;

  WalletCanister({required this.canisterId, required this.url});

  // A future method because we need debug mode works for local developement
  Future<void> setAgent(
      {String? newCanisterId,
      ServiceClass? newIdl,
      String? newUrl,
      Identity? newIdentity,
      bool? debug}) async {
    _agentFactory ??= await AgentFactory.createAgent(
        canisterId: newCanisterId ?? canisterId,
        url: newUrl ?? url,
        idl: newIdl ?? WalletCanisterMethod.idl,
        identity: newIdentity,
        debug: debug ?? true);
  }

  /// Call canister methods like this signature
  /// ```dart
  ///  CanisterActor.getFunc(String)?.call(List<dynamic>) -> Future<dynamic>
  /// ```

  Future<void> greet(String word) async {
    try {
      await actor?.getFunc(WalletCanisterMethod.greet)?.call([word]);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> spawnCreator() async {
    try {
      var res = await actor?.getFunc(WalletCanisterMethod.spawnCreator)!([]);
      if (res != null) {
        return res;
      }
      throw "Cannot get count but $res";
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getCaller() async {
    try {
      var res = await actor?.getFunc(WalletCanisterMethod.getCaller)!([]);
      if (res != null) {
        return res;
      }
      throw "Cannot get count but $res";
    } catch (e) {
      rethrow;
    }
  }

  Future<Principal> getPrincipal(String principalStr) async {
    try {
      Principal principal = await actor
          ?.getFunc(WalletCanisterMethod.getPrincipal)
          ?.call([principalStr]);
      return principal;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getCanisterRemainSpace() async {
    try {
      BigInt spacebyte =
          await actor?.getFunc(WalletCanisterMethod.getRemainSpace)!([]);
      return spacebyte.toInt() ~/ 1024;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> makeOrder(Principal principal, double price) async{
  try{
    BigInt priceb = BigInt.from(price*100000000);
    Map result = await actor?.getFunc(WalletCanisterMethod.makeOrder)?.call([principal,priceb]);

  } catch(e){
    rethrow;
  }

  }

  Future<NftData> getNft(String principalStr) async {
    var principal = await getPrincipal(principalStr);

    try {
      List records =
          await actor?.getFunc(WalletCanisterMethod.getNft)?.call([principal]);
      NftData data = NftData.transformData(records[0]);
      // record.containsKey(key)
      print('creater is ' + data.creater.toString());
      print('owner is ' + data.owner.toString());
      return data;

      // throw "Cannot get count but $res";
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NftData>> qureyNfts(int page) async {
    try {
      List records =
          await actor?.getFunc(WalletCanisterMethod.queryNfts)?.call([page]);
      List<NftData> nfts =
          records.map((map) => NftData.transformData(map)).toList();
      print("result is $nfts ");
      return nfts;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> mintNft(Uint8List data, Uint8List thumbnailData, String author,
      String title, String desc, String mediaType, int timeStamp) async {
    String principalStr = '';
    String principal =
        ICPAccountUtils.createPrincipal(timeStamp.toU8a()).toString();
    try {
      Map result = await actor?.getFunc(WalletCanisterMethod.mintNft)?.call([
        data,
        author,
        title,
        desc,
        mediaType,
        timeStamp,
        principal,
        thumbnailData
      ]);
      print('result is : ' + result.toString());
      if (result.containsKey('ok')) {
        principalStr = result.entries.elementAt(0).value.toString();
      }
      return principalStr;
    } catch (e) {
      rethrow;
    }
  }
}
