import 'package:flutter/material.dart';
import 'package:flutter_lotto/control/tool.dart';
import 'package:flutter_lotto/widget/draw_page.dart';
import 'package:flutter_lotto/widget/firestore_page.dart';
import 'package:flutter_lotto/widget/list_page.dart';
import 'package:flutter_lotto/widget/login_page.dart';
import 'package:flutter_lotto/widget/win_page.dart';
import 'control/lotto.dart';

import 'package:firebase_core/firebase_core.dart'; // 추가
import 'firebase_options.dart'; // 추가


// late Lotto lotto;
late List<List<int>> lottoList;
void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Flutter 바인딩을 초기화  . path_provider 와 관계가 있다.
  // lottoList = await Lotto.getListFromCSV();
  Lotto lotto = await Lotto.create();
  lottoList = lotto.wins;
  debugPrint(lottoList.length.toString());
  
  await Preferences.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); //추가

  // debugPrint('main in');
  // lotto = await Lotto.create();
  // debugPrint('main lotto');
  runApp(MyApp());
  // debugPrint('main out');

  // debugPrint('lotto.wins.length.toString() : ${lotto.wins.length.toString()}');
  // debugPrint('lotto.wins.last : ${lotto.wins.last}');
}

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _selectIndex = 2;
  PageController _pageController = PageController(initialPage: 2, viewportFraction: 2);

  void _onItemTapped(int index) {
    setState((){
      _selectIndex = index;
      
    });
    _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
  }

  // PageView에서 페이지가 변경될 때 호출
  void _onPageChanged(int index) {
    setState(() => _selectIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: [
            LoginPage(),
            DrawPage(lottoList),
            WinPage(lottoList),
            ListPage(lottoList),
            FirestorePage(),
          ],
        ),
        // floatingActionButton: FloatingActionButton(onPressed: (){}, child: const Icon(Icons.add),),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.login),
                label: '로그인',
                backgroundColor: Colors.lightBlue),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: '추천번호',
                backgroundColor: Colors.lightBlue),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '당첨번호',
                backgroundColor: Colors.lightBlue),
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: '당첨이력',
                backgroundColor: Colors.lightBlue),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: '파이어스토어',
              backgroundColor: Colors.lightBlue),
            // BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Third', backgroundColor: Colors.purple),
            // BottomNavigationBarItem(icon: Icon(Icons.heart_broken), label: 'Fourth', backgroundColor: Colors.pink),
          ],
          currentIndex: _selectIndex,
          selectedItemColor: Colors.yellow,
          onTap: _onItemTapped,
        ),
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: [
        //       DrawerHeader(child: Text('Drawer Header'), decoration: BoxDecoration(color: Colors.blue),),
        //       ListTile(title: Text('당첨번호'), onTap: (){_onItemTapped(0); _scaffoldKey.currentState?.closeDrawer();},),
        //       ListTile(title: Text('당첨이력'), onTap: (){_onItemTapped(1); _scaffoldKey.currentState?.closeDrawer();},),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
