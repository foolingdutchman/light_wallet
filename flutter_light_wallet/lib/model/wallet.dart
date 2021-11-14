import 'package:hive/hive.dart';

import 'token.dart';
part 'wallet.g.dart';

@HiveType(typeId: 0)
class Wallet {
  @HiveField(0)
  String password = '';
  @HiveField(1)
  String secrectKey = '';
  @HiveField(2)
  String principal = '';
  @HiveField(3)
  String mnomenic = '';
  @HiveField(4)
  String address = '';
  @HiveField(5)
  List<Token> tokenList = [];
  @HiveField(6)
  String guesturePassword = '';

  Wallet(List<Token> tokenList,
      {password = '',
      secrectKey = '',
      principal = '',
      address = '',
      mnomenic = '',
      guesturePassword = ''}) {
    this.password = password;
    this.secrectKey = secrectKey;
    this.principal = principal;
    this.address = address;
    this.mnomenic = mnomenic;
    this.tokenList = tokenList;
    this.guesturePassword = guesturePassword;
  }

  bool equals(Object? obj) {
    if (obj == null) {
      return false;
    } else if (obj is Wallet) {
      return this.address == obj.address;
    } else {
      return false;
    }
  }

  double getICPBalance() {
    Token icp = tokenList.firstWhere((element) => element.symbol == 'ICP');
    return icp.balance;
  }

  double getAvalidTransferAmount() {
    double amount = 0;
    if (getICPBalance() != 0 || getICPBalance() - 0.0001 > 0) {
      amount = getICPBalance() - 0.0001;
    }
    print("availid amount is : " + amount.toString());
    return amount;
  }
}
