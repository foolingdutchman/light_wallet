

import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/base/base_nft_page_state.dart';
import 'package:flutter_light_wallet/base/slide_right_route.dart';
import 'package:flutter_light_wallet/utils/event_bus_util.dart';
import 'package:flutter_light_wallet/utils/nft_canister.dart';
import 'package:flutter_light_wallet/view/nft/invoice_page.dart';

class InvoiceListView extends StatefulWidget {
  const InvoiceListView({Key? key}) : super(key: key);

  @override
  _InvoiceListViewState createState() => _InvoiceListViewState("invoice-list_view-detector");
}

class _InvoiceListViewState extends BaseNftPageState<InvoiceListView> {
  _InvoiceListViewState(String observerKey) : super(observerKey);
  List<Invoice> invoices =[];


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
       child:  Expanded(
         child: ListView.separated(
             itemBuilder: (context, position) => InkWell(
               onTap: () {
                 Navigator.push(
                     context,
                     SlideRightRoute(
                         page: InvociePage(
                           invoiceData:
                           invoices![position],
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
                         Text(invoices![position].isMintInvoice() ? "#Mint" : "#Purchase",
                           style: TextStyle(
                               fontSize: 16, fontWeight: FontWeight.bold),),
                         Text(invoices![position].value().toString() +" ICP",style: TextStyle(
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
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 "CounterAddress",

                                 style: TextStyle(
                                     fontSize: 14,
                                     fontWeight: FontWeight.bold),
                               ),
                               Text(invoices![position].counterAddress,maxLines: 1, overflow: TextOverflow.ellipsis,),
                               Text(
                                 "Token Principal",
                                 style: TextStyle(
                                     fontSize: 14,
                                     fontWeight: FontWeight.bold),
                               ),
                               Text(invoices![position].nft_principal.toString(),maxLines: 1, overflow: TextOverflow.ellipsis,),
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
             itemCount:  invoices.length),
       )
   );
  }

  @override
  void hanldEvent(Event event) {
    // TODO: implement hanldEvent
  }

  void _getMyInvoices() async {

    List<Invoice>? list = await walletCanister!.invoiceOf();
    if(list!= null && list.length != 0){
      invoices.clear();
      invoices.addAll(list);
      setState(() {

      });

    }
  }
}
