import 'package:flutter_light_wallet/utils/nft_canister.dart';

class NftDataStore{

   static List<NftDataWithOrder> nftData =[];
   static List<NftDataWithOrder> myNftData =[];
   static List<Invoice> myInvoices =[];

   static updateNftData(List<NftDataWithOrder> datas){
     nftData.clear();
     nftData.addAll(datas);
   }

   static updateMyNftData(List<NftDataWithOrder> datas){
     myNftData.clear();
     myNftData.addAll(datas);
   }

   static updateMyInvoices(List<Invoice> datas){
     myInvoices.clear();
     myInvoices.addAll(datas);

   }


   static clear(){

     nftData.clear();
     myNftData.clear();
     myInvoices.clear();
   }



}