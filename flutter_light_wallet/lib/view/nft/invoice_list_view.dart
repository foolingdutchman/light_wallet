import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_nft_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';
import 'package:flutter_light_wallet/view/nft/invoice_page.dart';
import 'package:flutter_light_wallet/view/nft/nft_data_store.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class InvoiceListView extends StatefulWidget {
  const InvoiceListView({Key? key}) : super(key: key);

  @override
  _InvoiceListViewState createState() =>
      _InvoiceListViewState("invoice-list_view-detector");
}

class _InvoiceListViewState extends BaseNftPageState<InvoiceListView> {
  _InvoiceListViewState(String observerKey) : super(observerKey);
  List<Invoice> invoices = NftDataStore.myInvoices;

  @override
  void afterCaniterInted() {
    _getMyInvoices();
  }

  @override
  Widget constructView(BuildContext context) {
    // TODO: implement constructView
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Expanded(
          child: Container(
            child: LiquidPullToRefresh(
              height: 50,
              color: Colors.transparent,
              showChildOpacityTransition: false,
              animSpeedFactor: 2,
              onRefresh: () {
                return _refreshData();
              },
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.separated(
                    itemBuilder: (context, position) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                SlideRightRoute(
                                    page: InvoicePage(
                                  invoiceData: invoices[position],
                                )));
                          },
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      invoices[position].getTypeString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      invoices[position].value().toString() +
                                          " ICP",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15.0,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.of(context).counter_address,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        invoices[position].counterAddress,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        S.of(context).token_id,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        invoices[position]
                                            .nft_principal
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                    separatorBuilder: (context, position) => new Divider(
                          height: 1,
                          color: Colors.black26,
                        ),
                    itemCount: invoices.length),
              ),
            ),
          ),
        ));
  }

  @override
  void hanldEvent(Event event) {
    // TODO: implement hanldEvent
    if (event is NftDataStoreUpdateEvent) {
      setState(() {
        invoices = NftDataStore.myInvoices;
      });
    }
  }

  void _getMyInvoices() async {
    if (!NftDataStore.isInvoiceDataFresh) {
      _refreshData();
    }
  }

  Future<void> _refreshData() async {
    SmartDialog.showLoading();
    await NftDataStore.fetchMyInvoiceData();
    SmartDialog.dismiss();
    setState(() {
      invoices = NftDataStore.myInvoices;
    });
  }
}
