import 'package:flutter/material.dart';
import '../control/tool.dart';

class ButtonIncrease extends StatefulWidget{
  final bool useSave;
  ButtonIncrease({this.useSave = false});
  @override
  State<StatefulWidget> createState() => _ButtonIncreaseState();
}

class _ButtonIncreaseState extends State<ButtonIncrease>{
  // State<ButtonIncrease> 에서 T get widget 이 있다. widget.useSave 이렇게 상위 맴버에 접근 할 수 있다. 
  int increaseState = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.useSave){
      increaseState = Preferences.getInt('increaseState') ?? 0;
    }
    return ElevatedButton(onPressed: (){setState(() {
      increaseState++;
      if(widget.useSave) Preferences.setInt('increaseState', increaseState);
      });}, 
      child: Text('$increaseState'),
      onLongPress: () {
        setState(() {
          increaseState = 0;
          if(widget.useSave) Preferences.setInt('increaseState', increaseState);
        });

      },
    );
  }

}