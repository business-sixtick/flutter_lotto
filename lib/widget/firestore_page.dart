import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  late String name;
  late String email;
  late int age;
  User({required this.name, required this.email, required this.age});
  User.fromMap(Map<String, dynamic> map): 
    name = map['name'], 
    email = map['email'],
    age = map['age'];

  Map<String, dynamic> toMap() => {'name': name, 'email': email, 'age': age};

  Future<void> add() async {
    try{
      CollectionReference ref = FirebaseFirestore.instance.collection('user');
      final querySnapshot = await ref.get(); 
      debugPrint(querySnapshot.size.toString());
      ref.doc('user${querySnapshot.size + 1}').set(toMap());// 없으면 만들고 있으면 업데이트
    }catch (e){
      debugPrint('add() 예외 : ${e.toString()}');
    }
  }

  Future<void> update() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('user');
    final querySnapshot = await ref.get(); 
    ref.doc('user${querySnapshot.size}').set(toMap()); // 마지막꺼 ㅋㅋ  업데이트가 따로 있긴하지만 그냥 덮어써~~
    // 헐 겁나 빠르네?? 
  }

  Future<void> test() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('user');
    ref.where('age', isGreaterThan: 30)
    .orderBy('age', descending: true)
    .limit(1)
    .get()
    .then((value){
      value.docs.forEach((item){
        debugPrint('result : ${item.get('name')}');
      });
    }).catchError((e) => debugPrint('test error : $e'));
  }

  // Future<void> 
}

class FirestorePage extends StatelessWidget{
  User user2 = User(age: 42, name: 'cho', email: 'a@a.com');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: (){user2.test();}, child: const Text('테스트')),
        const Text('테스트중'),
      ],
    );
  }
}