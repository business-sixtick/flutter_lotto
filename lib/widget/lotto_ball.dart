import 'package:flutter/material.dart';

class LottoBall extends StatelessWidget{
  late int number;
  LottoBall(this.number);

  @override
  Widget build(BuildContext context) {
    // debugPrint('height : '  + MediaQuery.of(context).size.height.toString());
    debugPrint('LottoBall : ' + MediaQuery.of(context).size.width.toString()); // 부모꺼임
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.yellow,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          debugPrint('constraints : ' + constraints.maxWidth.toString());
          return Center(child: Text(number.toString(), style: TextStyle(fontSize: constraints.maxWidth / 1.5, fontWeight: FontWeight.bold)));
        },
      // width: context.size,
      // height: 50,
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)],
      // ) ,
      )); 
  }
}