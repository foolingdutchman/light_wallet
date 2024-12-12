import 'dart:async';

import 'package:agent_dart/agent_dart.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/canister_util.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class NftDataStore {
  static List<NftDataWithOrder> nftData = [];
  static List<NftDataWithOrder> myNftData = [];
  static List<Invoice> myInvoices = [];
  static List<TransferRecord> myTransferRecords = [];
  static bool _isMyNftDatafresh = false;
  static bool _isNftDataFresh = false;
  static bool _isInvoiceDataFresh = false;
  static bool _isTransferRecordFresh = false;
  static WalletCanister? walletCanister;
  static bool isCanisterInit = false;
  static StreamSubscription<Event>? _subscription;
  static int nftDataPage = 1;
  static bool isAllNftFetched = false;

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
    if (dataSet != null && dataSet.length != 0) {
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

  static setMyInvoicesData(List<Invoice>? dataSet) {
    if (dataSet != null && dataSet.length != 0) {
      myInvoices.clear();
      myInvoices.addAll(dataSet);
    }
    _isInvoiceDataFresh = true;
  }

  static setMyTransferRecordsData(List<TransferRecord>? dataSet) {
    if (dataSet != null && dataSet.length != 0) {
      myTransferRecords.clear();
      myTransferRecords.addAll(dataSet);
    }
    _isTransferRecordFresh = true;
  }

  static clearNftData() {
    nftData.clear();
    _isNftDataFresh = false;
    nftDataPage = 1;
  }

  static clearInvoiceData() {
    myInvoices.clear();
    _isInvoiceDataFresh = false;
  }

  static clearTransferRecordsData() {
    myTransferRecords.clear();
    _isTransferRecordFresh = false;
  }

  static clearMyNftData() {
    myNftData.clear();
    _isMyNftDatafresh = false;
  }

  static bool get isTransferRecordFresh => _isTransferRecordFresh;

  static bool get isInvoiceDataFresh => _isInvoiceDataFresh;

  static bool get isNftDataFresh => _isNftDataFresh;

  static bool get isMyNftDatafresh => _isMyNftDatafresh;

  static void refreshCanister() async {
    isCanisterInit = false;
    walletCanister = await CanisterUtil.initWalletCanister();
    isCanisterInit = true;
    clearNftData();
    clearInvoiceData();
    clearMyNftData();
    clearTransferRecordsData();
    EventBusUtil.fire(NftDataStoreUpdateEvent());
  }

  static Future<void> fetchNftData() async {
    if (isCanisterInit) {
      List<NftDataWithOrder>? list =
          await walletCanister!.qureyNfts(nftDataPage);
      setNftData(list);
    } else {
      var init = await waitUitlCanisterInit();
      List<NftDataWithOrder>? list =
          await walletCanister!.qureyNfts(nftDataPage);
      setNftData(list);
    }
    isAllNftFetched = false;
    nftDataPage =1;

  }

  static Future<void> fetchAttachedNftData() async {
    if (isAllNftFetched) return;
    nftDataPage = nftDataPage + 1;
    if (isCanisterInit) {
      List<NftDataWithOrder>? list =
          await walletCanister!.qureyNfts(nftDataPage);
      if (list!.length == 0) {
        SmartDialog.showToast(S.current.no_more_data);
        isAllNftFetched = true;
      }
      attachNftData(list);
    } else {
      var init = await waitUitlCanisterInit();
      List<NftDataWithOrder>? list =
          await walletCanister!.qureyNfts(nftDataPage);
      if (list!.length == 0) {
        SmartDialog.showToast(S.current.no_more_data);
        isAllNftFetched = true;
      }
      attachNftData(list);
    }
  }

  static Future<void> fetchMyNftData() async {
    if (isCanisterInit) {
      List<NftDataWithOrder>? list = await walletCanister!.balanceOf();
      setMyNftData(list);
    } else {
      var init = await waitUitlCanisterInit();
      List<NftDataWithOrder>? list = await walletCanister!.balanceOf();
      setMyNftData(list);
    }
  }

  static Future<void> fetchMyTransferRecordsData() async {
    if (isCanisterInit) {
      List<TransferRecord>? list = await walletCanister!.getOwnTransferRecord();
      setMyTransferRecordsData(list);
    } else {
      var init = await waitUitlCanisterInit();
      List<TransferRecord>? list = await walletCanister!.getOwnTransferRecord();
      setMyTransferRecordsData(list);
    }
  }

  static Future<void> fetchMyInvoiceData() async {
    if (isCanisterInit) {
      List<Invoice>? list = await walletCanister!.invoiceOf();
      setMyInvoicesData(list);
    } else {
      var init = await waitUitlCanisterInit();
      List<Invoice>? list = await walletCanister!.invoiceOf();
      setMyInvoicesData(list);
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
    } else if (event is MintNftEvent || event is TransferNftEvent) {
      _fetchNftByPrincipal((event as NftInvoiceEvent).invoice);
    } else if (event is BurnNftEvent) {
      print("BurnNftEvent listened in store.....");
      removeStoreData(event.invoice);
    } else if (event is OrderNftEvent) {
      _addOrderToList(event.order);
    } else if (event is CancelOrderEvent) {
      _removeOrderFromList(event.principal);
    }
  }

  static updateStoreData(NftInvoiceEvent event) async {
    await fetchNftData();
    await fetchMyNftData();
    await fetchMyTransferRecordsData();
    _addInvoiceToList(event.invoice);
    EventBusUtil.fire(NftDataStoreUpdateEvent());
  }

  static removeStoreData(Invoice invoice) {
    NftDataWithOrder.removeDataByInovice(nftData, invoice);
    print("-----------------nftdata lenth is :" + nftData.length.toString());
    NftDataWithOrder.removeDataByInovice(myNftData, invoice);
    print("-----------------myNftdata lenth is :" + nftData.length.toString());
    _addInvoiceToList(invoice);
    print("-----------------add invoice principal :" +
        invoice.nft_principal.toString());
    clearTransferRecordsData();
    EventBusUtil.fire(NftDataStoreUpdateEvent());
  }

  static _addInvoiceToList(Invoice invoice) {
    if (Invoice.isListContain(myInvoices, invoice)) myInvoices.remove(invoice);
    myInvoices.insert(0, invoice);
  }

  static _addOrderToList(Order order) {
    NftDataWithOrder.addOrderToData(nftData, order);
    NftDataWithOrder.addOrderToData(myNftData, order);
    EventBusUtil.fire(NftDataStoreUpdateEvent());
  }

  static _removeOrderFromList(Principal principal) {
    NftDataWithOrder.removeOrderFromData(nftData, principal);
    NftDataWithOrder.removeOrderFromData(nftData, principal);
    EventBusUtil.fire(NftDataStoreUpdateEvent());
  }

  static _fetchNftByPrincipal(Invoice invoice) async {
    NftData? nft =
        await walletCanister!.getNft(invoice.nft_principal.toString());
    if (nft != null) {
      NftDataWithOrder data = NftDataWithOrder(nft, null);
      NftDataWithOrder.replaceData(nftData, data);
      NftDataWithOrder.replaceData(myNftData, data);
      _addInvoiceToList(invoice);
      clearTransferRecordsData();
      EventBusUtil.fire(NftDataStoreUpdateEvent());
    }
  }
}
