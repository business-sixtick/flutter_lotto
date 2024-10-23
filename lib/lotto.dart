import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:cp949_codec/cp949_codec.dart' as cp949;
import 'package:csv/csv.dart' as csv;
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'dart:math' as math;

// import 'dart:io' if (dart.library.html) 'dart:html' as html;
// import 'package:flutter/foundation.dart';  // kIsWeb 사용
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:path_provider/path_provider.dart';


class Lotto{
  late List<List<int>> wins;  
  late List<int> weights;
  Lotto._(this.wins, this.weights);  // private 생성자

  List<int> createWin(int weight){
    // int count = 0;
    List<int> weights = List.generate(45, (_) => 1, growable: false);
    for(var i = wins.length - 1; i >= wins.length - weight; i--){
      // print('${count++} ${wins[i]}');
      for(var j = 2; j < 8; j++){
        // if (i == 1140){
        //   print(wins[i][j]);  
        // }
        weights[wins[i][j] - 1]++  ;//= weights[wins[i][j] ] + 1;
      }
    }
    // print(weights);
    List<int> weightList = [];
    for (var i = 1; i < 46; i++){
      // print(i);
      for (var j = weights[i - 1]; j > 0; j--){
        // if(i == 1) print(j);
        weightList.add(i);
      }
    }
    // print(weightList);

    Set<int> win = {};
    while(win.length < 6){
      // win.add(math.Random().nextInt(45) + 1);
      win.add(weightList[math.Random().nextInt(weightList.length)]);
    }
    List<int> list  = win.toList();
    list.sort();
    
    

    return list;
  }

  // 비동기 팩토리 생성자
  static Future<Lotto> create() async {
    // 비동기적으로 wins 데이터를 가져옴
    List<List<int>> wins = await _getWins();
    List<int> weights = List.generate(45, (_) => 1, growable: false);
    return Lotto._(wins, weights);
  }

  static Future<List<List<int>>> _getWins() async {
    // TODO : 파일 접근 하는 방식을 수정해야함.. 데탑이랑 호환이 안됨.  dart:io말고 플러터꺼써야댐.
    var csvData = await rootBundle.loadString('assets/lotto.csv');
    // CSV 파일 읽기
    // if (kIsWeb){
    //   csvData = await rootBundle.loadString('asset/lotto.csv');
    // }else{
    //   final file = io.File('asset/lotto.csv');
    //   if (!await file.exists()){
    //     throw 'asset/lotto.csv 파일을 준비해 주세요.';
    //   }
    //   csvData = await file.readAsString();
    // }
    // print(csvData);
    // print(csvData.split('\r\n').length);
    
    // CSV 데이터를 파싱
    // List<List<int>> rows = const csv.CsvToListConverter().convert(csvData, );   // 뭐지 쓸데없이 파싱에러가 뜨네
    // List<List<int>> rows = const csv.CsvToListConverter().convert(csvData, eol: '\r\n');   // 뭐지 쓸데없이 파싱에러가 뜨네
    // List<List<int>> rows = csvData.split('\r\n').map((x) => x.split(',').map((y) => int.parse(y)));
    List<List<int>> rows = List<List<int>>.generate(csvData.split('\r\n').length, (index) => []);
    for (var line in csvData.split('\r\n')){
      
      int index = int.parse(line.split(',')[0]);
      for (var item in line.split(',')){
        
        rows[index - 1].add(int.parse(item));
      }
    }
    // print(rows);
    
    await _updateWins(rows);
    
    return rows;
  }

  static Future<void> _saveWins(List<List<int>> wins) async {
    // if (kIsWeb) {
    //   // 웹에서 파일 다운로드
    //   final blob = html.Blob([csvData], 'text/csv');
    //   final url = html.Url.createObjectUrlFromBlob(blob);
    //   final anchor = html.AnchorElement(href: url)
    //     ..setAttribute('download', 'lotto_saved.csv')
    //     ..click();
    //   html.Url.revokeObjectUrl(url);
    // } else {
    //   // 모바일/데스크톱에서 파일 저장
    //   final directory = await getApplicationDocumentsDirectory();
    //   final filePath = '${directory.path}/lotto_saved.csv';
    //   final file = File(filePath);
    //   await file.writeAsString(csvData);
    // }
    var file = io.File('asset/lotto.csv');
    String csvData = const csv.ListToCsvConverter().convert(wins);
    await file.writeAsString(csvData);
  }

  static Future<void> _updateWins(List<List<int>> wins) async {
    var list = wins;
    int today = DateTime.now().millisecondsSinceEpoch;
    int lately = list.last[1];

    if (today - lately < 604800000) return;

    while (today - lately > 604800000) {
      var item = await _getFromHomepageWins(list.length + 1);
      list.add(item);
      lately = item[1];
    }
    await _saveWins(list);
  }

  static Future<List<int>> _getFromHomepageWins(int turnNum) async {
    var url = Uri.https('dhlottery.co.kr', 'gameResult.do',{'method': 'byWin'});
    var response = await http.post(
      url, 
      body: {'drwNo': '$turnNum', 'hdrwComb': '1', 'dwrNoList' : '$turnNum'}
      );
    var regex = RegExp(r'\d+');
    var document = html.parse(cp949.cp949.decode(response.bodyBytes));
    var date = document.querySelector('p.desc')?.text;
    print(date);
    var date1 = date?.split(' ').map((e) =>  regex.allMatches(e).map((m) => m.group(0))).toList();
    print(date1);
    int year = int.parse(date1?[0].toList().join() ?? '');
    int month = int.parse(date1?[1].toList().join() ?? '');
    int  day= int.parse(date1?[2].toList().join() ?? '');
    
    String turn = regex.allMatches(document.querySelector('h4')?.text ?? '').map((e) => e.group(0)).toList().join();
    
    List<int> win = document.querySelectorAll('span.ball_645').map((element)=> int.parse(element.text)).toList();
    
    return <int>[int.parse(turn), DateTime(year, month, day).millisecondsSinceEpoch] + win;
  }
  
}
