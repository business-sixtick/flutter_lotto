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
      // debugPrint(ref.id);
      debugPrint(querySnapshot.size.toString());
      ref.doc('user${querySnapshot.size + 1}').set(toMap());
    }catch (e){
      debugPrint('add() 예외 : ${e.toString()}');
    }
    
    // await ref.add(toMap());
  }

  Future<void> update() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('user');
    final querySnapshot = await ref.get(); 
    ref.doc('user${querySnapshot.size}').set(toMap()); // 마지막꺼 ㅋㅋ  업데이트가 따로 있긴하지만 그냥 덮어써~~
    // 헐 겁나 빠르네?? 
  }

  // Future<void> 
}

class FirestorePage extends StatelessWidget{
  User user2 = User(age: 43, name: 'kim', email: 'a@a.com');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: (){user2.update();}, child: const Text('테스트')),
        const Text('테스트중'),
      ],
    );
  }
}