import 'package:flutter/material.dart';

class LottoBall extends StatelessWidget{
  late int number;
  LottoBall(this.number);

  @override
  Widget build(BuildContext context) {
    // debugPrint('height : '  + MediaQuery.of(context).size.height.toString());
    debugPrint('LottoBall : ' + MediaQuery.of(context).size.width.toString()); // 부모꺼임
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: ballColor(number),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          debugPrint('constraints : ' + constraints.maxWidth.toString());
          return Center(child: Text(number.toString(), style: TextStyle(fontSize: constraints.maxWidth * 0.7, fontWeight: FontWeight.bold)));
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

Color ballColor(int num){
  Color? color = Colors.grey;
  if(num < 12){
    color = Colors.orange[300];
  }else if(num < 22){
    color = Colors.lightBlue[300];
  }else if(num < 32){
    color = Colors.red[300];
  }else if(num < 42){
    color = Colors.grey[400];
  }else{
    color = Colors.green[300];
  }
  return color ?? Colors.grey;
}