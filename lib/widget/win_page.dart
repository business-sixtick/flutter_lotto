import 'package:flutter/material.dart';
import 'package:flutter_lotto/widget/lotto_ball.dart';

class WinPage extends StatelessWidget {
  late List<List<int>> lottoList;
  WinPage(this.lottoList);
  @override
  Widget build(BuildContext context) {
    double textSize = MediaQuery.of(context).size.width / 12;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${lottoList[lottoList.length - 1][0]} 회차',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: textSize,),
            
          ),
          Text(
            '${DateTime.fromMillisecondsSinceEpoch(lottoList[lottoList.length -1][1]).toString().split(' ')[0]}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: textSize,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: LottoBall(lottoList[lottoList.length - 1][2])),
              Expanded(child: LottoBall(lottoList[lottoList.length - 1][3])),
              Expanded(child: LottoBall(lottoList[lottoList.length - 1][4])),
              Expanded(child: LottoBall(lottoList[lottoList.length - 1][5])),
              Expanded(child: LottoBall(lottoList[lottoList.length - 1][6])),
              Expanded(child: LottoBall(lottoList[lottoList.length - 1][7])),
            ],
          ),
          Text(
            '보너스 번호 : ${lottoList[lottoList.length - 1][8]}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: textSize,),
            
          ),
        ],
      ),
    );
  }
}
