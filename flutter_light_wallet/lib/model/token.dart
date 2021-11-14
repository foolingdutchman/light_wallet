import 'package:hive/hive.dart';
part 'token.g.dart';

@HiveType(typeId: 1)
class Token {
  @HiveField(0)
  String symbol = '';
  @HiveField(1)
  double balance = 0;

  Token(String symbol, double balance) {
    this.symbol = symbol;
    this.balance = balance;
  }
  bool equals(Object obj) {
    if (!(obj is Token)) {
      return false;
    } else {
      return this.symbol == obj.symbol;
    }
  }
}
