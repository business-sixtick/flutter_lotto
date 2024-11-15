import 'package:flutter/material.dart';
import 'package:flutter_lotto/control/tool.dart';
import 'package:flutter_lotto/widget/lotto_ball.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../control/lotto.dart';
import '../control/lotto_sqflite.dart';

class WinPage extends StatelessWidget {
  late List<List<int>> lottoList;
  WinPage(this.lottoList);
  late SharedPreferences prefs;
  getPrefs() async{
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    getPrefs();
    _bottomSheet(){
      showModalBottomSheet(
        context: context, 
        backgroundColor: Colors.amber[100],

        builder: (Context){
          return SafeArea(
            child: FractionallySizedBox( // 일부분? 부속품? 파편?
              widthFactor: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 50,),
                  FutureBuilder(
                    // future: Lotto.getFromHomepageWins(lottoList[lottoList.length - 1][0]), 
                    future: LottoDb.create(), 
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // 로딩 중인 상태
                      }
                      // 에러 상태 처리
                      else if (snapshot.hasError) {
                        return Text('에러 발생: ${snapshot.error}');
                      }
                      // 데이터 로드 완료 시
                      else if (snapshot.hasData) {
                        // return Text(snapshot.data.toString() ?? '데이터가 없습니다');
                        LottoDb lottoDb = snapshot.data; 
                        return Text(lottoDb.wins.length.toString() ?? '데이터가 없습니다');
                      }
                      // 기본 상태 처리
                      else {
                        return Text('데이터를 로드할 수 없습니다');
                      }
                    }),
                    SizedBox(height: 50,),
                    ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text('닫기')),                    
                    SizedBox(height: 20,),
                ],
              ),
            )
            );
        });
    }
    double textSize = MediaQuery.of(context).size.width / 12;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200,),
            Text(
              '${lottoList[lottoList.length - 1][0]} 회차',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: textSize,),
              
            ),
            Text(
              '${DateTime.fromMillisecondsSinceEpoch(lottoList[lottoList.length -1][1]).toString().split(' ')[0]}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: textSize,),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
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
            ),
            Text(
              '보너스 번호 : ${lottoList[lottoList.length - 1][8]}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: textSize,),
              
            ),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: _bottomSheet, child: Text('테스트')),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: ()=>showToast(prefs.getString('email') ?? '', context), child: Text('토스트 테스트')),
          ],
        ),
      ),
    );
  }
}
