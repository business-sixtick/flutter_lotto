import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi; // 윈도우에서 쓰려면 sqlite3.dll 이 필요하다. https://sqlite.org/download.html
import 'lotto.dart';
import 'dart:io';

/// ``` LottoDb lottoDb = LottoDb.create(); ```
/// - 다른것은 쓰지 않아도 됨. 내부에 리스트를 갖고 있음.
class LottoDb{
  late sqflite.Database db;
  late List<Win> wins;
  final String table = 'lotto';
  LottoDb._(this.db, this.wins);

  static Future<LottoDb> create() async {
    const String createQuery = '''create table lotto (
        turn integer primary key,
        date integer,
        win1 integer,
        win2 integer,
        win3 integer,
        win4 integer,
        win5 integer,
        win6 integer,
        win7 integer)''';

    var db;
    if (Platform.isWindows){
      // print('Platform.isWindows');
      sqflite_ffi.databaseFactory = sqflite_ffi.databaseFactoryFfi;
      db = await sqflite_ffi.openDatabase('lotto.db');
      var result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?", ['lotto']);
      // var result = await db.rawQuery('SELECT COUNT(*) FROM lotto');
      if(result.isEmpty){ // 테이블이 없으면 생성
        await db.execute(createQuery);
      }
    }else{
      db = await sqflite.openDatabase('lotto.db',version: 1,  onCreate: (sqflite.Database db, int version) async {
        await db.execute(createQuery);
      }, onUpgrade: (db, oldVersion, newVersion) {
        // 오픈시에 버전을 변경하면 실행됨
      },);
    }
      
    List<Win> wins = [];
    var list = await db.query('lotto');
    if (list.isNotEmpty){
      for (var i in list){
        wins.add(Win.formMap(i));
      }
    }else{ // 비어있다
      Lotto lotto = await Lotto.create();
      await Future.wait(lotto.wins.map((win) async {
        wins.add(Win(win[0], win[1], win[2], win[3], win[4], win[5], win[6], win[7], win[8]));
        await db.insert('lotto', {'turn': win[0], 'date': win[1], 'win1': win[2], 'win2': win[3], 'win3': win[4], 'win4': win[5], 'win5': win[6], 'win6': win[7], 'win7': win[8]});
      }));
    }
    
    // print('wins.last.turn : ${wins.last.turn}'); // 
    // 갱신해야하는가?
    int today = DateTime.now().millisecondsSinceEpoch;
    int lately = wins.last.date;
    final int nextTime = const Duration(days: 7, hours:21).inMilliseconds;
    // if (today - lately < nextTime) return list;
    while (today - lately > nextTime) {
      print('while in');
      var win = await Lotto.getFromHomepageWins(wins.length + 1);
      wins.add(Win(win[0], win[1], win[2], win[3], win[4], win[5], win[6], win[7], win[8]));
      await db.insert('lotto', {'turn': win[0], 'date': win[1], 'win1': win[2], 'win2': win[3], 'win3': win[4], 'win4': win[5], 'win5': win[6], 'win6': win[7], 'win7': win[8]});
      lately = win[1];
    }

    return LottoDb._(db, wins);
  }

  Future<int> getCount() async {
    var result = await db.rawQuery('SELECT COUNT(*) FROM $table');
    if (result.length == 1){
      // print('result[0].values.first : ${result[0].values.first}');
      return int.parse(result[0].values.first.toString());
    }
    return -1;
  }

  Future<int> insert(List<int> win) async {
    return await db.insert(table, {'turn': win[0], 'date': win[1], 'win1': win[2], 'win2': win[3], 'win3': win[4], 'win4': win[5], 'win5': win[6], 'win6': win[7], 'win7': win[8]});
  }

  Future<Win> getWin(int turn) async {
    var result = await db.query(table, where: 'turn=?', whereArgs: [turn]);
    if (result.isNotEmpty){
      Map<String, Object?> item = result[0];
      return Win.formMap(item);
    }
    return Win(0,0,0,0,0,0,0,0,0); 
  }

  Future<int> deleteWin(int turn) async {
    return await db.delete(table, where: 'turn=?', whereArgs: [turn]);
  }
  
  Future<List<Win>> getWins() async {
    var result = await db.query(table);
    if (result.isNotEmpty){
      List<Win> wins = [];
      for (var i in result){
        wins.add(Win.formMap(i));
      }
      return wins;
    }
    return [Win(0,0,0,0,0,0,0,0,0)]; 
  }
  
}

// void main() async {
  
//   var lottoDb = await LottoDb.create();
  
//   print('lottoDb.wins.length : ${lottoDb.wins.length}');
//   print('lottoDb.wins.last.turn : ${lottoDb.wins.last.turn}');
//   // print('delete : ${await lottoDb.deleteWin(lottoDb.wins.last.turn)}');
// }
