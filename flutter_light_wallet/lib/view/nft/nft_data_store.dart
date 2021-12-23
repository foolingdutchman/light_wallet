import 'dart:async';

import 'package:agent_dart/agent_dart.dart';
import 'package:flutter_light_wallet/utils/canister_util.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';

class NftDataStore {
  static List<NftDataWithOrder> nftData = [];
  static List<NftDataWithOrder> myNftData = [];
  static List<Invoice> myInvoices = [];
  static List<TransferRecord> myTransferRecords = [];
  static bool _isMyNftDatafresh = false;
  static bool _isNftDataFresh = false;
  static bool _isInvoiceDataFresh = false;
  static bool _isOrderDataFresh = false;
  static WalletCanister? walletCanister;
  static bool isCanisterInit = false;
  static StreamSubscription<Event>? _subscription;
  static  int nftDataPage = 1;

  static init() async {
    walletCanister = await CanisterUtil.initWalletCanister();
    isCanisterInit = true;
    _subscription = EventBusUtil.listen((event) {
      print('event received!');
      hanldEvent(event);
    });
  }

  static void release() {
    _subscription?.cancel();
  }

  static updateNftData(List<NftDataWithOrder> datas) {
    nftData.clear();
    nftData.addAll(datas);
  }

  static updateMyNftData(List<NftDataWithOrder> datas) {
    myNftData.clear();
    myNftData.addAll(datas);
  }

  static updateMyInvoices(List<Invoice> datas) {
    myInvoices.clear();
    myInvoices.addAll(datas);
  }

  static setNftData(List<NftDataWithOrder>? dataSet) {
    if (dataSet != null && dataSet.length != 0) {
      nftData.clear();
      nftData.addAll(dataSet);
    }
    _isNftDataFresh = true;
  }

  static attachNftData(List<NftDataWithOrder>? dataSet) {
    if (dataSet!=null&&dataSet.length != 0) {
      nftData.addAll(dataSet);
    }
    _isNftDataFresh = true;
  }

  static setMyNftData(List<NftDataWithOrder>? dataSet) {
    if (dataSet != null && dataSet.length != 0) {
      myNftData.clear();
      myNftData.addAll(dataSet);
    }
    _isMyNftDatafresh = true;
  }

  static setMyInvoicesData(List<Invoice> dataSet) {
    if (dataSet.length != 0) {
      myInvoices.clear();
      myInvoices.addAll(dataSet);
    }
    _isInvoiceDataFresh = true;
  }

  static setMyTransferRecordsData(List<TransferRecord>? dataSet) {
    if (dataSet!=null&& dataSet.length != 0) {
      myTransferRecords.clear();
      myTransferRecords.addAll(dataSet);
    }
    _isOrderDataFresh = true;
  }

  static clearNftData() {
    nftData.clear();
    _isNftDataFresh = false;
    nftDataPage =1;
  }

  static clearInvoiceData() {
    myInvoices.clear();
    _isInvoiceDataFresh = false;
  }

  static clearTransferRecordsData() {
    myTransferRecords.clear();
    _isOrderDataFresh = false;
  }

  static clearMyNftData() {
    myNftData.clear();
    _isMyNftDatafresh = false;
  }

  static bool get isOrderDataFresh => _isOrderDataFresh;

  static bool get isInvoiceDataFresh => _isInvoiceDataFresh;

  static bool get isNftDataFresh => _isNftDataFresh;

  static bool get isMyNftDatafresh => _isMyNftDatafresh;



  static void refreshCanister() async {
    isCanisterInit = false;
    walletCanister = await CanisterUtil.initWalletCanister();
    isCanisterInit = true;
  }

  static void fetchNftData() async {
    if (isCanisterInit) {
      List<NftDataWithOrder>? list = await walletCanister!.qureyNfts(nftDataPage);
      setNftData(list);

    } else {
      var init = await waitUitlCanisterInit();
      List<NftDataWithOrder>? list = await walletCanister!.qureyNfts(nftDataPage);
      setNftData(list);
    }
  }

  static void fetchAttachedNftData() async{
    nftDataPage +=1;
    if (isCanisterInit) {
      List<NftDataWithOrder>? list = await walletCanister!.qureyNfts(nftDataPage);
      attachNftData(list);

    } else {
      var init = await waitUitlCanisterInit();
      List<NftDataWithOrder>? list = await walletCanister!.qureyNfts(nftDataPage);
      attachNftData(list);
    }
  }

  static void fetchMyNftData() async {
    if (isCanisterInit) {
      List<NftDataWithOrder>? list = await walletCanister!.balanceOf();
      setMyNftData(list);
    } else {
      var init = await waitUitlCanisterInit();
      List<NftDataWithOrder>? list = await walletCanister!.balanceOf();
      setMyNftData(list);
    }
  }


  static fetchMyTransferRecordsData() async{

    if (isCanisterInit) {
      List<TransferRecord>? list = await walletCanister!.getOwnTransferRecord();
      setMyTransferRecordsData(list);
    } else {
      var init = await waitUitlCanisterInit();
      List<TransferRecord>? list = await walletCanister!.getOwnTransferRecord();
      setMyTransferRecordsData(list);
    }
  }

  static Future<bool> waitUitlCanisterInit() async {
    while (isCanisterInit) {
      print("AM waiting.....");
      waitUitlCanisterInit();
    }
    return true;
  }

  static void hanldEvent(Event event) {
    if (event is SwitchWalletEvent) {
      refreshCanister();
    }
  }
}
