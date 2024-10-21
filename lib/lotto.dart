import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:cp949_codec/cp949_codec.dart' as cp949;
import 'package:csv/csv.dart' as csv;
import 'dart:io' as io;

class Lotto{
  // late Future<List<List<int>>> wins;

  // Lotto._(this.wins);  // private 생성자

  // // 팩토리 생성자에서 비동기 작업 수행
  // static Future<Lotto> create() async {
  //   var instance = Lotto._(await _readWins());
  //   await instance._updateWins();  // 비동기 작업 수행
  //   return instance;
  // }

  // Lotto(){
  //   wins = _readWins();
  //   wins.then((value) => _updateWins());
  // }


  static Future<List<List<int>>> getWins() async {
    // CSV 파일 읽기
    final file = io.File('asset/lotto.csv');
    if (!await file.exists()){
      throw 'asset/lotto.csv 파일을 준비해 주세요.';
    }
    final csvData = await file.readAsString();
    // print(csvData);
    // CSV 데이터를 파싱
    List<List<int>> rows = const csv.CsvToListConverter().convert(csvData);
    
    await _updateWins(rows);
    
    return rows;
  }

  static Future<void> _saveWins(List<List<int>> wins) async {
    var file = io.File('asset/lotto.csv');
    String csvData = const csv.ListToCsvConverter().convert(wins);
    await file.writeAsString(csvData);
  }

  static Future<void> _updateWins(List<List<int>> wins) async {
    var list = wins;
    int today = DateTime.now().millisecondsSinceEpoch;
    int lately = list.last[1];
    while (today - lately > 604800000) {
      var item = await _getFromHomepageWins(lately + 1);
      list.add(item);
      lately = item[1];
    }
    await _saveWins(list);
  }

  static Future<List<int>> _getFromHomepageWins(int turnNum) async {
    var url = Uri.https('dhlottery.co.kr', 'gameResult.do',{'method': 'byWin'});
    var response = await http.post(
      url, 
      body: {'drwNo': turnNum, 'hdrwComb': '1', 'dwrNoList' : turnNum}
      );
    var regex = RegExp(r'\d+');
    var document = html.parse(cp949.cp949.decode(response.bodyBytes));
    var date = document.querySelector('p.desc')?.text;
    var date1 = date?.split(' ').map((e) =>  regex.allMatches(e).map((m) => m.group(0))).toList();
    int year = int.parse(date1?[0].toList().join() ?? '');
    int month = int.parse(date1?[1].toList().join() ?? '');
    int  day= int.parse(date1?[2].toList().join() ?? '');
    
    String turn = regex.allMatches(document.querySelector('h4')?.text ?? '').map((e) => e.group(0)).toList().join();
    
    List<int> win = document.querySelectorAll('span.ball_645').map((element)=> int.parse(element.text)).toList();
    
    return <int>[int.parse(turn), DateTime(year, month, day).millisecondsSinceEpoch] + win;
  }
  
}
