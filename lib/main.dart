import 'package:flutter/material.dart';
import 'lotto.dart';
import 'package:get/get.dart';


class Wins {
  Lotto? lotto;
  List<int> win;
  Wins(this.win);
}

// UserController 클래스 정의
class UserController extends GetxController {
  var win = Wins([1,2,3,4,5,6]).obs; // User 클래스를 Rx로 감쌉니다.
}


void main() {
  
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  

  MyApp({super.key}){
    // wins = lotto.Lotto().wins;
    // Lotto.getWins().then((onValue) => debugPrint(onValue.toString()));
    //debugPrint('main : ${wins.last[1].toString()}');
  }

  // late var wins;// = await lotto.Lotto().wins;
  // debugPrint('main : ${wins.last[1].toString()}');
  // final PageController controller = PageController(initialPage: 1, viewportFraction: 0.7);
  PageController controller = PageController(initialPage: 1, viewportFraction: 1);
  final UserController productController = Get.put(UserController());
  @override  
  Widget build(BuildContext context) {
    // wins = await lotto.Lotto().wins;
    
    return MaterialApp(
      home: Scaffold(appBar: AppBar(title: const Text('test'),),
      body: PageView(
        controller: controller,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            color: Colors.red,
            child: const Center(
              child: Text('Onepage', style: TextStyle(color: Colors.white, fontSize: 30),),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            color: Colors.green,
            child: const Center(
              child: Text('Twopage', style: TextStyle(color: Colors.white, fontSize: 30),),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            color: Colors.blue,
            child: const Center(
              child: Text('Threepage', style: TextStyle(color: Colors.white, fontSize: 30),),
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