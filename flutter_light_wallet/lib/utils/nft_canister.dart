import 'dart:typed_data';
import 'package:agent_dart/agent_dart.dart';
import 'package:agent_dart/candid/idl.dart';
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
  static const isPrivate = 'price';
}

class Order {
  int? id;
  int? timestamp_nanos;
  Principal? principal;
  Principal? owner;
  int? price;


}

class NftData {
  int? id;
  String author = "";
  String title = "";
  String desc = "";
  String mediaType = "";
  int? timeStamp;
  Uint8List? thumbnail;
  Principal? principal;
  Principal? owner;
  Principal? creater;
  bool isPrivate= false;

  NftData(
      int id,
      int timeStamp,
      String author,
      String title,
      String desc,
      String mediaType,
      Uint8List? thumbnail,
      Principal? principal,
      Principal? owner,
      Principal? creater,
      bool isPrivate,
      ) {
    this.principal = principal;
    this.timeStamp = timeStamp;
    this.title = title;
    this.author = author;
    this.creater = creater;
    this.desc = desc;
    this.id = id;
    this.mediaType = mediaType;
    this.owner = owner;
    this.isPrivate = isPrivate;
    this.thumbnail = thumbnail;
  }

  static NftData transformData(Map map) {
    return NftData(
        map[WalletCanisterProperty.id].toInt(),
        map[WalletCanisterProperty.timeStamp].toInt(),
        map[WalletCanisterProperty.author],
        map[WalletCanisterProperty.title],
        map[WalletCanisterProperty.desc],
        map[WalletCanisterProperty.mediaType],
        Uint8List.fromList(map[WalletCanisterProperty.thumbnail].cast<int>()),
        map[WalletCanisterProperty.principal],
        map[WalletCanisterProperty.owner],
        map[WalletCanisterProperty.creater],
        map[WalletCanisterProperty.isPrivate],

    );
  }
}

 class CanisterMethod {
  /// use staic const as method name
  static const getCaller = "getCaller";
  static const getNft = 'getNft';
  static const getNftAddress = 'getNftAddress';
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
  static const getContractInfo = 'getContractInfo';
  static const balanceOf = 'balanceOf';
  static const confirmOrder = 'confirmOrder';
  static const getTokenByPrincipalString = 'getTokenByPrincipalString';
  static const getTokenMetaByPrincipalString = 'getTokenMetaByPrincipalString';
  static const getTokenWithOrderByIndex = 'getTokenWithOrderByIndex';
  static const getTokenWithOrderByPrincipalString = 'getTokenWithOrderByPrincipalString';
  static const mint = 'mint';
  static const claimMintInvoice = 'claimMintInvoice';
  static const getMintPrice = 'getMintPrice';
}

class ServiceProperties {
  
   static final Error = IDL.Variant({
    'Immutable': IDL.Null,
    'NotFound': IDL.Null,
    'Unauthorized': IDL.Null,
    'InvalidRequest': IDL.Null,
    'AuthorizedPrincipalLimitReached': IDL.Nat,
    'FailedToWrite': IDL.Text,
  });
  static final Result_1 = IDL.Variant({'ok': IDL.Principal, 'err': Error});
  static final UncheckInvoice = IDL.Variant({
    'Mint': IDL.Record({
      'counterAddress': IDL.Text,
      'timeStamp': IDL.Nat64,
      'issueTo': IDL.Principal,
      'charge': IDL.Nat64,
      'nft_principal': IDL.Principal,
    }),
    'Purchase': IDL.Record({
      'counterAddress': IDL.Text,
      'timeStamp': IDL.Nat64,
      'issueTo': IDL.Principal,
      'charge': IDL.Nat64,
      'amount': IDL.Nat64,
      'receiptAddress': IDL.Text,
      'nft_principal': IDL.Principal,
    }),
  });
  static final Result_7 = IDL.Variant({'ok': UncheckInvoice, 'err': Error});
  static final Order = IDL.Record({
    'id': IDL.Nat,
    'timestamp_nanos': IDL.Nat64,
    'principal': IDL.Principal,
    'owner': IDL.Principal,
    'price': IDL.Nat64,
  });
  static final Invoice = IDL.Variant({
    'Mint': IDL.Record({
      'id': IDL.Nat,
      'counterAddress': IDL.Text,
      'timeStamp': IDL.Nat64,
      'issueTo': IDL.Principal,
      'charge': IDL.Nat64,
      'nft_principal': IDL.Principal,
      'checktimeStamp': IDL.Nat64,
    }),
    'Purchase': IDL.Record({
      'id': IDL.Nat,
      'counterAddress': IDL.Text,
      'timeStamp': IDL.Nat64,
      'issueTo': IDL.Principal,
      'charge': IDL.Nat64,
      'amount': IDL.Nat64,
      'receiptAddress': IDL.Text,
      'nft_principal': IDL.Principal,
      'checktimeStamp': IDL.Nat64,
    }),
  });
  static final Result_5 = IDL.Variant({'ok': Invoice, 'err': Error});
  static final ContractInfo = IDL.Record({
    'nft_payload_size': IDL.Nat,
    'memory_size': IDL.Nat,
    'max_live_size': IDL.Nat,
    'cycles': IDL.Nat,
    'total_minted': IDL.Nat,
    'heap_size': IDL.Nat,
    'authorized_users': IDL.Vec(IDL.Principal),
  });
  static final ContractMetadata = IDL.Record({
    'name': IDL.Text,
    'symbol': IDL.Text,
  });
  static final Time = IDL.Int;
  static final TransferRecord = IDL.Record({
    'to': IDL.Principal,
    'transaction_hash': IDL.Nat,
    'timeStamp': Time,
    'from': IDL.Principal,
    'nftPrincipal': IDL.Principal,
  });
  static final NftData = IDL.Record({
    'id': IDL.Nat,
    'title': IDL.Text,
    'creater': IDL.Principal,
    'principal': IDL.Principal,
    'thumbnail': IDL.Vec(IDL.Nat8),
    'owner': IDL.Principal,
    'timeStamp': Time,
    'desc': IDL.Text,
    'author': IDL.Text,
    'isPrivate': IDL.Bool,
    'mediaType': IDL.Text,
  });
  static final Result_3 = IDL.Variant({'ok': NftData, 'err': Error});
  static final Result_2 = IDL.Variant({'ok': IDL.Vec(IDL.Nat8), 'err': Error});
  static final NftDatawithOrder = IDL.Record({
    'order': IDL.Opt(Order),
    'nftData': NftData,
  });
  static final Result_6 = IDL.Variant({'ok': NftDatawithOrder, 'err': Error});
  static final PublicNftData = IDL.Record({
    'title': IDL.Text,
    'thumbnail': IDL.Vec(IDL.Nat8),
    'desc': IDL.Text,
    'author': IDL.Text,
    'isPrivate': IDL.Bool,
    'mediaType': IDL.Text,
  });
  static final Result_4 = IDL.Variant({
    'ok': IDL.Vec(NftDatawithOrder),
    'err': Error,
  });
  static final Result = IDL.Variant({'ok': IDL.Null, 'err': Error});

}

ServiceClass _initService() {

 
  final LWalletNft = IDL.Service({
    'balanceOf': IDL.Func(
      [IDL.Principal],
      [IDL.Vec(IDL.Principal)],
      ['query'],
    ),
    'cancelOrder': IDL.Func([IDL.Principal], [ServiceProperties.Result_1], []),
    'claimMintInvoice': IDL.Func([IDL.Nat, IDL.Principal], [ServiceProperties.Result_7], []),
    'claimPurchaseInvoice': IDL.Func([ServiceProperties.Order], [ServiceProperties.UncheckInvoice], []),
    'confirmOrder': IDL.Func(
      [IDL.Principal, IDL.Nat64, ServiceProperties.UncheckInvoice],
      [ServiceProperties.Result_5],
      [],
    ),
    'getCaller': IDL.Func([], [IDL.Text], []),
    'getCallerAddress': IDL.Func([], [IDL.Text], []),
    'getContractInfo': IDL.Func([], [ServiceProperties.ContractInfo], []),
    'getMetadata': IDL.Func([], [ServiceProperties.ContractMetadata], ['query']),
    'getMintPrice': IDL.Func([IDL.Nat], [IDL.Nat64], []),
    'getOwnTransferRecord': IDL.Func([], [IDL.Vec(ServiceProperties.TransferRecord)], []),
    'getOwner': IDL.Func([], [IDL.Principal], []),
    'getPrincipal': IDL.Func([IDL.Text], [IDL.Principal], []),
    'getRemainSpace': IDL.Func([], [IDL.Nat], []),
    'getTokenByPrincipalString': IDL.Func([IDL.Text], [ServiceProperties.Result_3], []),
    'getTokenMetaByPrincipalString': IDL.Func([IDL.Text], [ServiceProperties.Result_2], []),
    'getTokenWithOrderByIndex': IDL.Func([IDL.Nat], [ServiceProperties.Result_6], []),
    'getTokenWithOrderByPrincipalString': IDL.Func([IDL.Text], [ServiceProperties.Result_6], []),
    'getTransferRecordByHash': IDL.Func(
      [IDL.Nat],
      [IDL.Vec(ServiceProperties.TransferRecord)],
      ['query'],
    ),
    'getTransferRecordByPrincipal': IDL.Func(
      [IDL.Principal],
      [IDL.Vec(ServiceProperties.TransferRecord)],
      ['query'],
    ),
    'init': IDL.Func([IDL.Vec(IDL.Principal), ServiceProperties.ContractMetadata], [], []),
    'makeOrder': IDL.Func([IDL.Principal, IDL.Nat64], [ServiceProperties.Result_1], []),
    'mint': IDL.Func(
      [
        ServiceProperties.PublicNftData, IDL.Text, IDL.Vec(IDL.Nat8), IDL.Nat64, ServiceProperties.UncheckInvoice],
      [ServiceProperties.Result_5],
      [],
    ),
    'ownerOf': IDL.Func([IDL.Text], [ServiceProperties.Result_1], ['query']),
    'queryNftsWithOrder': IDL.Func([IDL.Nat], [ServiceProperties.Result_4], []),
    'spawnCreator': IDL.Func([], [IDL.Text], []),
    'tokenByIndex': IDL.Func([IDL.Nat], [ServiceProperties.Result_3], []),
    'tokenMetaByIndex': IDL.Func([IDL.Nat], [ServiceProperties.Result_2], []),
    'transfer': IDL.Func([IDL.Principal, IDL.Text], [ServiceProperties.Result], []),
    'updateOrder': IDL.Func([IDL.Principal, IDL.Nat64], [ServiceProperties.Result_1], []),
    'updateTokenPrivate': IDL.Func([IDL.Principal, IDL.Bool], [ServiceProperties.Result], []),
    'wallet_receive': IDL.Func([], [], []),
  });
  return LWalletNft;

 
  
  
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
  Future<void> setAgent({String? newCanisterId,
    ServiceClass? newIdl,
    String? newUrl,
    Identity? newIdentity,
    bool? debug}) async {
    _agentFactory ??= await AgentFactory.createAgent(
        canisterId: newCanisterId ?? canisterId,
        url: newUrl ?? url,
        idl: newIdl ?? _initService(),
        identity: newIdentity,
        debug: debug ?? true);
  }

  /// Call canister methods like this signature
  /// ```dart
  ///  CanisterActor.getFunc(String)?.call(List<dynamic>) -> Future<dynamic>
  /// ```

 

  Future<String> spawnCreator() async {
    try {
      var res = await actor?.getFunc(CanisterMethod.spawnCreator)!([]);
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
      var res = await actor?.getFunc(CanisterMethod.getCaller)!([]);
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
          ?.getFunc(CanisterMethod.getPrincipal)
          ?.call([principalStr]);
      return principal;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getContractInfo() async{
    try {
      Map response =
      await actor?.getFunc(CanisterMethod.getContractInfo)!([]);
      print("result is: " + response.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getCanisterRemainSpace() async {
    try {
      BigInt spacebyte =
      await actor?.getFunc(CanisterMethod.getRemainSpace)!([]);
      return spacebyte.toInt() ~/ 1024;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> makeOrder(Principal principal, double price) async {
    try {
      BigInt priceb = BigInt.from(price * 100000000);
      Map result = await actor?.getFunc(CanisterMethod.makeOrder)?.call(
          [principal, priceb]);
    } catch (e) {
      rethrow;
    }
  }
 Future<Map?> claimMintInvoice(String principalStr,int dataSize) async {
    try {
      Principal principal =Principal.fromText(principalStr);
      BigInt size = BigInt.from(dataSize);
      Map result = await actor?.getFunc(CanisterMethod.claimMintInvoice)?.call(
          [size, principal]);
      print('resp is ' + result.toString());
      if (result.containsKey('ok')) {
           Map inv = result.entries.elementAt(0).value.entries.firstWhere((e) => e.key == 'Mint').value;
           print('invoice is ' + inv.toString());
           return inv;
      }

    } catch (e) {
      rethrow;
    }
  }


  Future<BigInt> getMintPrice(int dataSize) async {
    try {
      BigInt size = BigInt.from(dataSize);
      BigInt price  = await actor?.getFunc(CanisterMethod.getMintPrice)?.call(
          [size]);
      return price;
    } catch (e) {
      rethrow;
    }
  }




  Future<NftData> getNft(String principalStr) async {
    var principal = await getPrincipal(principalStr);

    try {
      List records =
      await actor?.getFunc(CanisterMethod.getNft)?.call([principal]);
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
      await actor?.getFunc(CanisterMethod.queryNfts)?.call([page]);
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
      Map result = await actor?.getFunc(CanisterMethod.mint)?.call([
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
        principalStr = result.entries
            .elementAt(0)
            .value
            .toString();
      }
      return principalStr;
    } catch (e) {
      rethrow;
    }
  }
}
