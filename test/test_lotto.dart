import 'package:flutter_lotto/lotto.dart';


void main() async {
  Lotto  lotto = await Lotto.create();
  // print(lotto.wins);
  print(lotto.createWin(10));
}