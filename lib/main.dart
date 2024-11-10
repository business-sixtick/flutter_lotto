import 'package:flutter/material.dart';
import 'package:flutter_lotto/widget/list_page.dart';
import 'package:flutter_lotto/widget/lotto_ball.dart';
import 'lotto.dart';


// late Lotto lotto;
late List<List<int>> lottoList;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Flutter 바인딩을 초기화  . path_provider 와 관계가 있다. 
  lottoList = await Lotto.getListFromCSV();
  debugPrint(lottoList.length.toString());

  // debugPrint('main in');
  // lotto = await Lotto.create();
  // debugPrint('main lotto');
  runApp(MyApp());
  // debugPrint('main out');

  // debugPrint('lotto.wins.length.toString() : ${lotto.wins.length.toString()}');
  // debugPrint('lotto.wins.last : ${lotto.wins.last}');
  
} 

class MyApp extends StatefulWidget{
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp>{
  int _selectIndex = 0;
  List<Widget> _widgetOptions = [
    // Text('first Screen', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
    Center(
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
    ListPage(lottoList),
    Text('third Screen', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
    Text('fourth Screen', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
  ];

  void _onItemTapped(int index){
    setState(() => _selectIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('AppBar Title'),
        ),
        // appBar: AppBar(
        //   bottom: PreferredSize(preferredSize: const Size.fromHeight(48), child: Theme(
        //     data: ThemeData.from(colorScheme: ColorScheme.fromSwatch(accentColor: Colors.white)), 
        //     child: Container(height: 48, alignment: Alignment.center, child: Text('AppBar Bottom Text')))),
        //     flexibleSpace: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/girl2.jpeg'),
        //       fit: BoxFit.fill)),),
        //     title: Text('AppBar Title'),
        //     actions: [
        //       IconButton(onPressed: (){}, icon: const Icon(Icons.add_alert)),
        //       IconButton(onPressed: (){}, icon: const Icon(Icons.phone)),
        //     ],
        // ),
        body: Center(child: _widgetOptions.elementAt(_selectIndex),),
        // floatingActionButton: FloatingActionButton(onPressed: (){}, child: const Icon(Icons.add),),
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.shifting,
        //   items: [
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'First', backgroundColor: Colors.green),
        //     BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Second', backgroundColor: Colors.red),
        //     BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Third', backgroundColor: Colors.purple),
        //     BottomNavigationBarItem(icon: Icon(Icons.heart_broken), label: 'Fourth', backgroundColor: Colors.pink),
        //   ],
        //   currentIndex: _selectIndex,
        //   selectedItemColor: Colors.amber[800],
        //   onTap: _onItemTapped,
        //   ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(child: Text('Drawer Header'), decoration: BoxDecoration(color: Colors.blue),),
              ListTile(title: Text('당첨번호'), onTap: (){_onItemTapped(0); _scaffoldKey.currentState?.closeDrawer();},),
              ListTile(title: Text('당첨이력'), onTap: (){_onItemTapped(1); _scaffoldKey.currentState?.closeDrawer();},),
            ],
          ),
        ),
      ),
    );
  }

}