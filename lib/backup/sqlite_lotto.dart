import 'dart:async';
import 'package:flutter/services.dart' as services ;       //rootBundle.loadString



class Win {
  late int turn;
  late int date;
  late String day;
  late int win1;
  late int win2;
  late int win3;
  late int win4;
  late int win5;
  late int win6;
  late int win7;

  Win(this.turn, this.date, this.win1, this.win2, this.win3, this.win4, this.win5, this.win6, this.win7){
    day = DateTime.fromMillisecondsSinceEpoch(date).toString();
  }

  Map<String, dynamic> toMap(){
    return {
      'turn' : turn,
      'date': date,
      'win1': win1,
      'win2': win2,
      'win3': win3,
      'win4': win4,
      'win5': win5,
      'win6': win6,
      'win7': win7
    };
  }
}

class Lotto{

  static Future<List<List<int>>> getListFromCSV() async {
    var csvData = await services.rootBundle.loadString('assets/lotto.csv');

    List<List<int>> rows = List<List<int>>.generate(csvData.split('\r\n').length, (index) => []);
    for (var line in csvData.split('\r\n')){
      int index = int.parse(line.split(',')[0]);
      for (var item in line.split(',')){
        rows[index - 1].add(int.parse(item));
      }
    }
    return rows;
  }

  
}

// import 'package:flutter/services.dart' show rootBundle;
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// Future<Database> openDatabaseFromAssets() async {
//   // assets 디렉토리에서 DB 파일을 로드
//   final ByteData data = await rootBundle.load('assets/database.db');
//   final List<int> bytes =
//       data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  
//   // 임시 디렉토리에 파일 저장
//   final String path = join(await getDatabasesPath(), 'database.db');
//   await File(path).writeAsBytes(bytes, flush: true);
  
//   // 데이터베이스 열기
//   return await openDatabase(path);
// }



// static Future<dynamic> getItemFromSqlite(var key) async {
//     databaseFactory = databaseFactory;
//     var factory = sqlite.getIdbFactorySqflite(databaseFactory);
//     // define the store name
//     const String storeName = "lotto";

//     // open the database
//     sqlite.Database db = await factory.open("$storeName.db", version: 1,
//       onUpgradeNeeded: (sqlite.VersionChangeEvent event) {
//         sqlite.Database db = event.database;
//       // create the store
//         db.createObjectStore(storeName, autoIncrement: true);
//       });

//     // // put some data
//     // var txn = db.transaction(storeName, idbModeReadWrite);
//     // var store = txn.objectStore(storeName);
//     // var key = await store.put({"some": "data"});
//     // await txn.completed;

//     // read some data
//     var txn = db.transaction(storeName, sqlite.idbModeReadOnly);
//     var store = txn.objectStore(storeName);
//     var value = await store.getObject(key);
//     await txn.completed;
//     return value;
//   }

//   static Future<dynamic> addItemFromSqlite(var value) async {
//     databaseFactory = databaseFactory;
//     var factory = sqlite.getIdbFactorySqflite(databaseFactory);
//     // define the store name
//     const String storeName = "lotto";

//     // open the database
//     sqlite.Database db = await factory.open("$storeName.db", version: 1,
//       onUpgradeNeeded: (sqlite.VersionChangeEvent event) {
//         sqlite.Database db = event.database;
//       // create the store
//         db.createObjectStore(storeName, autoIncrement: true);
//       });

//     // put some data
//     var txn = db.transaction(storeName, sqlite.idbModeReadWrite);
//     var store = txn.objectStore(storeName);
//     var key = await store.put({"some": "data"});
//     await txn.completed;

//     return key;
//   }

// class SqliteLotto {

//   static Database? _database;
//   static const String table = 'lotto';
  
//   /// 데이터베이스를 초기화하고 ' 테이블이 없으면 생성합니다.
//   static Future<Database> _initDatabase() async {
    
//     var factory = getIdbFactorySqflite(databaseFactory);
//     // 데이터베이스 파일 경로를 얻어옵니다 
//     // String path = await rootBundle.loadString('assets/lotto.db');
//     // String path = 'assets/lotto.db';
//     final ByteData data = await rootBundle.load('assets/lotto.db');
//     final List<int> bytes =
//         data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    
//     // 임시 디렉토리에 파일 저장
//     final String path = join(await getDatabasesPath(), 'lotto.db');
//     bool exists = await File(path).exists();
//     print(path);
//     print(exists.toString());
//     if (exists){

//     }else{
//       await File(path).writeAsBytes(bytes, flush: true);
//     }
//     // 지정된 버전 및 생성 콜백으로 데이터베이스를 엽니다.
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         // 'todos' 테이블을 생성하는 SQL 쿼리를 실행합니다.
//         await db.execute('''
//           CREATE TABLE $table(
//             turn INTEGER PRIMARY KEY,
//             date INTEGER,
//             win1 INTEGER,
//             win2 INTEGER,
//             win3 INTEGER,
//             win4 INTEGER,
//             win5 INTEGER,
//             win6 INTEGER,
//             win7 INTEGER
//           )
//         ''');
//       },
//     );
//   }

//   static Future<int> insertWin(Win win) async {
//     Database db = _database ?? await _initDatabase();
//     return await db.insert(table, win.toMap());
//   }

//   static Future<List<Win>> queryWin() async {
//     Database db = _database ?? await _initDatabase();
//     List<Map<String, dynamic>> data = await db.query(table);

//     return List.generate(data.length, (i){
//       return Win(
//         data[i]['turn'], data[i]['date'],data[i]['win1'],data[i]['win2'],data[i]['win3'],data[i]['win4'],data[i]['win5'],data[i]['win6'],data[i]['win7']
//       );
//     });
//   }
// }