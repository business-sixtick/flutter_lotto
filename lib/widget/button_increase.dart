import 'package:flutter/material.dart';
import '../control/tool.dart';

class ButtonIncrease extends StatefulWidget{
  final bool useSave;
  ButtonIncrease({this.useSave = false});
  @override
  State<StatefulWidget> createState() => _ButtonIncreaseState();
}

class _ButtonIncreaseState extends State<ButtonIncrease>{
  
  // _ButtonIncreaseState(this.useSave);
  // final bool useSave;
  int increaseState = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.useSave){
      increaseState = Preferences.getInt('increaseState') ?? 0;
    }
    return ElevatedButton(onPressed: (){setState(() {
      increaseState++;
      Preferences.setInt('increaseState', increaseState);
    });}, child: Text('$increaseState'));
  }

}