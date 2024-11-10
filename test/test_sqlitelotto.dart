import 'package:flutter/material.dart';
import 'package:flutter_lotto/backup/sqlite_lotto.dart';


void main() async {
  var list = await Lotto.getListFromCSV();
  print(list);
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('test'),
        ),
      ),
    );

  }
}