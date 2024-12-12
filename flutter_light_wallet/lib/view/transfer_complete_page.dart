import 'package:flutter/material.dart';
import 'package:flutter_light_wallet/generated/l10n.dart';
import 'package:flutter_light_wallet/utils/rosetta_utils.dart';

class TransactionCompletePage extends StatelessWidget {
  final BigInt height;
  const TransactionCompletePage({Key? key, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 150, left: 30, right: 30),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  size: 150,
                  color: Colors.green,
                ),
              ),
              Text(
                S.of(context).transfer_success,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
               S.of(context).block_height+ ':' + height.toString() + ".",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.all(Size(150, 50)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(S.of(context).back)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _checkBlockInfo() async {
    await RosettaUtils.getBlockByHeight(height);
  }

  @override
  StatelessElement createElement() {
    _checkBlockInfo();
    return super.createElement();
  }
}
