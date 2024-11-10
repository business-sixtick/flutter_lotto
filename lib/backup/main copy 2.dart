import 'package:flutter/material.dart';
import '../control/lotto.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter/foundation.dart';



// UserController 클래스 정의
class UserController extends GetxController {
  var win = Win(1,DateTime.now().millisecondsSinceEpoch,3,4,5,6,7,8,9).obs;
  var selectPage = 1.obs;
  var createWin = Win(0,DateTime.now().millisecondsSinceEpoch,0,0,0,0,0,0,0).obs;
}

late Lotto lotto;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Flutter 바인딩을 초기화  . path_provider 와 관계가 있다. 
  debugPrint('main in');
  lotto = await Lotto.create();
  debugPrint('main lotto');
  // debugPrint('lotto.directory : ${lotto.directory}');
  runApp(MyApp());
  debugPrint('main out');

  debugPrint('lotto.wins.length.toString() : ${lotto.wins.length.toString()}');
  debugPrint('lotto.wins.last : ${lotto.wins.last}');
}

class CircleNumber extends StatelessWidget{
  late String text;
  CircleNumber(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle
      ),
      width: 50,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)],
      ) ,
    );
  }
}


class MyApp extends StatelessWidget{
  

  MyApp({super.key}){
    wins = lotto.wins;
    // Lotto.getWins().then((onValue) => debugPrint(onValue.toString()));
    //debugPrint('main : ${wins.last[1].toString()}');
  }

  late var wins;// = await lotto.Lotto().wins;
  // debugPrint('main : ${wins.last[1].toString()}');
  // final PageController controller = PageController(initialPage: 1, viewportFraction: 0.7);
  PageController controller = PageController(initialPage: 1, viewportFraction: 1);
  final UserController userController = Get.put(UserController());

  void tapPage(int index){
    userController.selectPage.value = index;
    controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    // controller.initialPage = 1;
  }
  
  @override  
  Widget build(BuildContext context) {
    // wins = await lotto.Lotto().wins;
    userController.win.value = Win(
      lotto.wins.last[0],
      lotto.wins.last[1],
      lotto.wins.last[2],
      lotto.wins.last[3],
      lotto.wins.last[4],
      lotto.wins.last[5],
      lotto.wins.last[6],
      lotto.wins.last[7],
      lotto.wins.last[8]
      );  
    return GetMaterialApp(
      locale: Locale('en', 'US'), // 초기 언어 설정
      fallbackLocale: Locale('en', 'US'), // 언어 설정 실패 시 기본 언어
      localizationsDelegates: GlobalMaterialLocalizations.delegates, // 지역화 설정
      supportedLocales: const [
        Locale('en', 'US'), // 영어
        Locale('ko', 'KR'), // 한국어
      ],
      home: Scaffold(
        appBar: AppBar(title: const Text('로또 번호 생성기 : 여기에 광고를 넣어야지')), 
        // floatingActionButton: FloatingActionButton(onPressed: (){
        //   showDialog(context: context,
        //   barrierDismissible: false, 
        //   builder: (BuildContext context){
        //     return AlertDialog(

        //       title: Text('number'),
        //       content: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           // Obx((){
        //           //   List<int> winArr = lotto.createWin(10);
        //           //   return Text('${winArr[0]} ${winArr[1]} ${winArr[2]} ${winArr[3]} ${winArr[4]} ${winArr[5]}');
        //           // }),
        //           Text('test')
        //           ],
        //         ),
        //         actions: [TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))],
                
        //       );}
        //     );
        //   }
          
        // , child: const Icon(Icons.add),),
        // TODO Obx 로 감싸서 currentIndex 상태변경해줘야됨.
        bottomNavigationBar: Obx((){

          return BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.graphic_eq_sharp), label: 'WEIGHT', backgroundColor: Colors.blue),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME', backgroundColor: Colors.blue),
              BottomNavigationBarItem(icon: Icon(Icons.work), label: 'CREATE', backgroundColor: Colors.blue),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'HISTORY', backgroundColor: Colors.blue),
            ],
            currentIndex: userController.selectPage.value,
            selectedItemColor: Colors.yellow,
            onTap: tapPage,
          );}),
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.shifting,
        //   items: [
        //     BottomNavigationBarItem(icon: Icon(Icons.graphic_eq_sharp), label: 'WEIGHT', backgroundColor: Colors.green),
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME', backgroundColor: Colors.red),
        //     BottomNavigationBarItem(icon: Icon(Icons.work), label: 'CREATE', backgroundColor: Colors.blue),
        //     BottomNavigationBarItem(icon: Icon(Icons.list), label: 'HISTORY', backgroundColor: Colors.purple),
        //   ],
        //   currentIndex: userController.selectPage.value,
        //   selectedItemColor: Colors.deepPurpleAccent,
        //   onTap: tapPage,
        //   ),
        body: PageView(
          controller: controller,
          onPageChanged: (int page)=> userController.selectPage.value = page,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              color: Colors.red,
              child: Center(
                child: Image.asset('assets/mybankqr.png')
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              color: Colors.green,
              child: Center(
                
                child: Column(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                    Obx(() => Text('${userController.win.value.turn} 회', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), )),
                    Obx(() => Text('당첨일 : ${userController.win.value.day.split(" ")[0]}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), )),
                    Row(
                      mainAxisAlignment : MainAxisAlignment.center,
                      children: [
                        Obx(() => CircleNumber('${userController.win.value.win1}')),
                        Obx(() => CircleNumber('${userController.win.value.win2}')),
                        Obx(() => CircleNumber('${userController.win.value.win3}')),
                        Obx(() => CircleNumber('${userController.win.value.win4}')),
                        Obx(() => CircleNumber('${userController.win.value.win5}')),
                        Obx(() => CircleNumber('${userController.win.value.win6}')),

                      ],
                    ),
                    Row(
                      mainAxisAlignment : MainAxisAlignment.center,
                      children: [
                        Text('보너스 번호 : ', style: TextStyle(fontSize: 30),),
                        Obx(() => CircleNumber('${userController.win.value.win7}')),
                      ],
                    )
                  ] 
                ) 
                // Obx(() => Text('Twopage ${userController.win.value.turn}', style: TextStyle(color: Colors.white, fontSize: 30),)),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              color: Colors.blue,
              child: Obx(() {
                
                return Center(
                  child: Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    children: [ 
                      Row(
                        mainAxisAlignment : MainAxisAlignment.center,
                        children:[
                          CircleNumber('${userController.createWin.value.win1}'),
                          CircleNumber('${userController.createWin.value.win2}'),
                          CircleNumber('${userController.createWin.value.win3}'),
                          CircleNumber('${userController.createWin.value.win4}'),
                          CircleNumber('${userController.createWin.value.win5}'),
                          CircleNumber('${userController.createWin.value.win6}'),
                        ],
                      ),
                      Container(height: 200,),
                      ElevatedButton(onPressed: (){
                        //  debugPrint(Sqlite.table);
                        
                        List<int> createWins = lotto.createWin(10);
                        userController.createWin.value = Win(0, DateTime.now().millisecondsSinceEpoch, createWins[0], createWins[1], createWins[2], createWins[3], createWins[4], createWins[5], 0);
                      }, child: Text('생성'))
                    ] 
                  ) 
                
                );
              },) 
            ),
            Container(
              margin: const EdgeInsets.all(20),
              color: Colors.white,
              child: Center(
                child: ListView.separated(
                  itemCount: lotto.wins.length,
                  // itemCount: 0,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: CircleAvatar(radius: 25, child: Text(' >> '),),
                      title: Text("${lotto.wins[lotto.wins.length - (index + 1)][0]}회  :  "
                        '${lotto.wins[lotto.wins.length - (index + 1)][2]},  '
                        '${lotto.wins[lotto.wins.length - (index + 1)][3]},  '
                        '${lotto.wins[lotto.wins.length - (index + 1)][4]},  '
                        '${lotto.wins[lotto.wins.length - (index + 1)][5]},  '
                        '${lotto.wins[lotto.wins.length - (index + 1)][6]},  '
                        '${lotto.wins[lotto.wins.length - (index + 1)][7]}  +  '
                        '${lotto.wins[lotto.wins.length - (index + 1)][8]}  '
                      ),
                      subtitle: Text("${DateTime.fromMillisecondsSinceEpoch(lotto.wins[lotto.wins.length - (index + 1)][1]).toString().split(' ')[0]}"),
                      // trailing: Container(
                      //   width: 500,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       CircleNumber('${lotto.wins[lotto.wins.length - (index + 1)][2]}'),
                      //       CircleNumber('${lotto.wins[lotto.wins.length - (index + 1)][3]}'),
                      //       CircleNumber('${lotto.wins[lotto.wins.length - (index + 1)][4]}'),
                      //       CircleNumber('${lotto.wins[lotto.wins.length - (index + 1)][5]}'),
                      //       CircleNumber('${lotto.wins[lotto.wins.length - (index + 1)][6]}'),
                      //       CircleNumber('${lotto.wins[lotto.wins.length - (index + 1)][7]}'),
                      //       Icon(Icons.add),
                      //       CircleNumber('${lotto.wins[lotto.wins.length - (index + 1)][8]}'),
                      //     ],
                      //   ),
                      // ),

                    );
                  } ,
                  separatorBuilder: (context, index){
                    return Divider(height: 4,);
                  },
                  )
              ),
            ),
          // FutureBuilder(future: Lotto.getWins(), builder: (context, snapshot){
          //   if (snapshot.hasData){
          //     return Center(
          //       child: Text('${snapshot.data?.length}'),
          //     );
          //   }
          //   return Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         SizedBox(width: 100, height: 100, child: CircularProgressIndicator(),),
          //         Text('waiting...')
          //       ],
          //     ),
          //   );
          // })
        ],
        
      ),
      )
    );
  }
}