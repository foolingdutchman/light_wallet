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

  NftData(int id,
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

 class WalletCanisterMethod {
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
  static const getContractInfo = 'getContractInfo';
}

ServiceClass _initService() {
  final Property = IDL.Rec();
  final Query = IDL.Rec();
  final Update = IDL.Rec();
  final Callback = IDL.Func([], [], []);
  final Properties = IDL.Vec(Property);
  final ContractMetadata = IDL.Record({
    'name': IDL.Text,
    'symbol': IDL.Text,
  });
  final Metadata = IDL.Record({
    'id': IDL.Text,
    'contentType': IDL.Text,
    'owner': IDL.Principal,
    'createdAt': IDL.Int,
    'properties': Properties,
  });
  final Chunk = IDL.Record({
    'data': IDL.Vec(IDL.Nat8),
    'totalPages': IDL.Nat,
    'nextPage': IDL.Opt(IDL.Nat),
  });
  final PayloadResult = IDL.Variant({
    'Complete': IDL.Vec(IDL.Nat8),
    'Chunk': Chunk,
  });
  final PublicToken = IDL.Record({
    'id': IDL.Text,
    'contentType': IDL.Text,
    'owner': IDL.Principal,
    'createdAt': IDL.Int,
    'properties': Properties,
    'payload': PayloadResult,
  });
  final WriteAsset = IDL.Variant({
    'Init': IDL.Record({
      'id': IDL.Text,
      'size': IDL.Nat,
      'callback': IDL.Opt(Callback),
    }),
    'Chunk': IDL.Record({
      'id': IDL.Text,
      'chunk': IDL.Vec(IDL.Nat8),
      'callback': IDL.Opt(Callback),
    }),
  });
  final AssetRequest = IDL.Variant({
    'Put': IDL.Record({
      'key': IDL.Text,
      'contentType': IDL.Text,
      'callback': IDL.Opt(Callback),
      'payload': IDL.Variant({
        'StagedData': IDL.Null,
        'Payload': IDL.Vec(IDL.Nat8),
      }),
    }),
    'Remove': IDL.Record({ 'key': IDL.Text, 'callback': IDL.Opt(Callback)}),
    'StagedWrite': WriteAsset,
  });
  final Error = IDL.Variant({
    'Immutable': IDL.Null,
    'NotFound': IDL.Null,
    'Unauthorized': IDL.Null,
    'InvalidRequest': IDL.Null,
    'AuthorizedPrincipalLimitReached': IDL.Nat,
    'FailedToWrite': IDL.Text,
  });
  final Result = IDL.Variant({ 'ok': IDL.Text, 'err': Error});
  final Result_1 = IDL.Variant({ 'ok': Properties, 'err': Error});
  final Result_2 = IDL.Variant({ 'ok': IDL.Null, 'err': Error});
  final Result_3 = IDL.Variant({ 'ok': Metadata, 'err': Error});
  final Result_4 = IDL.Variant({ 'ok': Chunk, 'err': Error});
  final Result_5 = IDL.Variant({ 'ok': PublicToken, 'err': Error});
  final Result_6 = IDL.Variant({ 'ok': IDL.Principal, 'err': Error});

  final AuthorizeRequest = IDL.Record({
    'p': IDL.Principal,
    'id': IDL.Text,
    'isAuthorized': IDL.Bool,
  });
  final  ContractInfo = IDL.Record({
    'nft_payload_size': IDL.Nat,
    'memory_size': IDL.Nat,
    'max_live_size': IDL.Nat,
    'cycles': IDL.Nat,
    'total_minted': IDL.Nat,
    'heap_size': IDL.Nat,
    'authorized_users': IDL.Vec(IDL.Principal),
  });
   final TopupCallback = IDL.Func([], [], []);
   final Contract = IDL.Variant({
    'ContractAuthorize': IDL.Record({
      'isAuthorized': IDL.Bool,
      'user': IDL.Principal,
    }),
    'Mint': IDL.Record({ 'id': IDL.Text, 'owner': IDL.Principal}),
  });
   final Token = IDL.Variant({
    'Authorize': IDL.Record({
      'id': IDL.Text,
      'isAuthorized': IDL.Bool,
      'user': IDL.Principal,
    }),
    'Transfer': IDL.Record({
      'id': IDL.Text,
      'to': IDL.Principal,
      'from': IDL.Principal,
    }),
  });
   final Message = IDL.Record({
    'topupCallback': TopupCallback,
    'createdAt': IDL.Int,
    'topupAmount': IDL.Nat,
    'event': IDL.Variant({ 'ContractEvent': Contract, 'TokenEvent': Token}),
  });
   final Callback__1 = IDL.Func([Message], [], []);
   final CallbackStatus = IDL.Record({
    'failedCalls': IDL.Nat,
    'failedCallsLimit': IDL.Nat,
    'callback': IDL.Opt(Callback__1),
    'noTopupCallLimit': IDL.Nat,
    'callsSinceLastTopup': IDL.Nat,
  });

   final HeaderField = IDL.Tuple([IDL.Text, IDL.Text]);
   final Request = IDL.Record({
    'url': IDL.Text,
    'method': IDL.Text,
    'body': IDL.Vec(IDL.Nat8),
    'headers': IDL.Vec(HeaderField),
  });
   final StreamingCallbackToken = IDL.Record({
    'key': IDL.Text,
    'index': IDL.Nat,
    'content_encoding': IDL.Text,
  });
   final StreamingCallbackResponse = IDL.Record({
    'token': IDL.Opt(StreamingCallbackToken),
    'body': IDL.Vec(IDL.Nat8),
  });
   final StreamingCallback = IDL.Func(
    [StreamingCallbackToken],
    [StreamingCallbackResponse],
    ['query'],
  );
   final StreamingStrategy = IDL.Variant({
    'Callback': IDL.Record({
      'token': StreamingCallbackToken,
      'callback': StreamingCallback,
    }),
  });
   final Response = IDL.Record({
    'body': IDL.Vec(IDL.Nat8),
    'headers': IDL.Vec(HeaderField),
    'streaming_strategy': IDL.Opt(StreamingStrategy),
    'status_code': IDL.Nat16,
  });
   final Value = IDL.Variant({
    'Int': IDL.Int,
    'Nat': IDL.Nat,
    'Empty': IDL.Null,
    'Bool': IDL.Bool,
    'Text': IDL.Text,
    'Float': IDL.Float64,
    'Principal': IDL.Principal,
    'Class': IDL.Vec(Property),
  });
  Property.fill(
      IDL.Record({ 'value': Value, 'name': IDL.Text, 'immutable': IDL.Bool})
  );

   final Egg = IDL.Record({
    'contentType': IDL.Text,
    'owner': IDL.Opt(IDL.Principal),
    'properties': Properties,
    'isPrivate': IDL.Bool,
    'payload': IDL.Variant({
      'StagedData': IDL.Text,
      'Payload': IDL.Vec(IDL.Nat8),
    }),
  });

  Query.fill(IDL.Record({ 'name': IDL.Text, 'next': IDL.Vec(Query)}));
  final QueryMode = IDL.Variant(
      { 'All': IDL.Null, 'Some': IDL.Vec(Query)});

  final QueryRequest = IDL.Record({ 'id': IDL.Text, 'mode': QueryMode});


  final UpdateEventCallback = IDL.Variant({
    'Set': Callback__1,
    'Remove': IDL.Null,
  });
   final UpdateMode = IDL.Variant(
      { 'Set': Value, 'Next': IDL.Vec(Update)});
  Update.fill(IDL.Record({ 'mode': UpdateMode, 'name': IDL.Text}));
   final UpdateRequest = IDL.Record({
    'id': IDL.Text,
    'update': IDL.Vec(Update),
  });
   final WriteNFT = IDL.Variant({
    'Init': IDL.Record({ 'size': IDL.Nat, 'callback': IDL.Opt(Callback)}),
    'Chunk': IDL.Record({
      'id': IDL.Text,
      'chunk': IDL.Vec(IDL.Nat8),
      'callback': IDL.Opt(Callback),
    }),
  });
  final ServiceClass Hub = IDL.Service({
    'assetRequest': IDL.Func([AssetRequest], [Result_2], []),
    'authorize': IDL.Func([AuthorizeRequest], [Result_2], []),
    'balanceOf': IDL.Func([IDL.Principal], [IDL.Vec(IDL.Text)], ['query']),
    'getAuthorized': IDL.Func([IDL.Text], [IDL.Vec(IDL.Principal)], ['query']),
    'getContractInfo': IDL.Func([], [ContractInfo], []),
    'getEventCallbackStatus': IDL.Func([], [CallbackStatus], []),
    'getMetadata': IDL.Func([], [ContractMetadata], ['query']),
    'getTotalMinted': IDL.Func([], [IDL.Nat], ['query']),
    'http_request': IDL.Func([Request], [Response], ['query']),
    'http_request_streaming_callback': IDL.Func(
      [StreamingCallbackToken],
      [StreamingCallbackResponse],
      ['query'],
    ),
    'init': IDL.Func([IDL.Vec(IDL.Principal), ContractMetadata], [], []),
    'isAuthorized': IDL.Func([IDL.Text, IDL.Principal], [IDL.Bool], ['query']),
    'listAssets': IDL.Func(
      [],
      [IDL.Vec(IDL.Tuple([IDL.Text, IDL.Text, IDL.Nat]))],
      ['query'],
    ),
    'mint': IDL.Func([Egg], [Result], []),
    'nftStreamingCallback': IDL.Func(
      [StreamingCallbackToken],
      [StreamingCallbackResponse],
      ['query'],
    ),
    'ownerOf': IDL.Func([IDL.Text], [Result_6], ['query']),
    'queryProperties': IDL.Func([QueryRequest], [Result_1], ['query']),
    'staticStreamingCallback': IDL.Func(
      [StreamingCallbackToken],
      [StreamingCallbackResponse],
      ['query'],
    ),
    'tokenByIndex': IDL.Func([IDL.Text], [Result_5], []),
    'tokenChunkByIndex': IDL.Func([IDL.Text, IDL.Nat], [Result_4], []),
    'tokenMetadataByIndex': IDL.Func([IDL.Text], [Result_3], []),
    'transfer': IDL.Func([IDL.Principal, IDL.Text], [Result_2], []),
    'updateContractOwners': IDL.Func(
      [IDL.Principal, IDL.Bool],
      [Result_2],
      [],
    ),
    'updateEventCallback': IDL.Func([UpdateEventCallback], [], []),
    'updateProperties': IDL.Func([UpdateRequest], [Result_1], []),
    'wallet_receive': IDL.Func([], [], []),
    'writeStaged': IDL.Func([WriteNFT], [Result], []),
  });


  return Hub;
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

  Future<void> getContractInfo() async{
    try {
      Map response =
      await actor?.getFunc(WalletCanisterMethod.getContractInfo)!([]);
      print("result is: " + response.toString());
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

  Future<void> makeOrder(Principal principal, double price) async {
    try {
      BigInt priceb = BigInt.from(price * 100000000);
      Map result = await actor?.getFunc(WalletCanisterMethod.makeOrder)?.call(
          [principal, priceb]);
    } catch (e) {
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
