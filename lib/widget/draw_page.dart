import 'package:flutter/material.dart';
import 'package:flutter_lotto/control/lotto.dart';
import 'package:flutter_lotto/widget/lotto_ball.dart';
import 'package:provider/provider.dart';

class DrawState extends ChangeNotifier {
  late List<int> list;
  DrawState(this.list);
  void setState(List<int> data) {
    list = data;
    notifyListeners();
  }
}

class DrawPage extends StatelessWidget {
  late List<List<int>> list;
  DrawPage(this.list);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DrawState(Lotto.drawWin(list)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('* 경 고 *', style: TextStyle(color: Colors.red),),
              Text('본 앱은 투자에 관해'),
              Text('어떠한 책임도 지지않습니다.'),
              SizedBox(height: 20,),
              DrawList(),
              SizedBox(height: 100,),
              DrawButton(list)
            ],
          ),
        ));
  }
}

class DrawButton extends StatelessWidget {
  late List<List<int>> list;
  DrawButton(this.list);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<DrawState>(); // state 가져오기
    debugPrint('DrawButton');
    return ElevatedButton(
      
        onPressed: () => state.setState(Lotto.drawWin(list)),
        child: Text('생성'));
  }
}

class DrawList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<DrawState>(); // state 가져오기
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: LottoBall(state.list[0])),
          Expanded(child: LottoBall(state.list[1])),
          Expanded(child: LottoBall(state.list[2])),
          Expanded(child: LottoBall(state.list[3])),
          Expanded(child: LottoBall(state.list[4])),
          Expanded(child: LottoBall(state.list[5])),
        ],
      ),
    );
  }
}
