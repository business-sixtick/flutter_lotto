import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../control/tool.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String? email;

  String? password;

  // 로그인 상태가 와야함 TODO
  // late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
  }


  

  @override
  Widget build(BuildContext context) {

    signUp() async {
      try{
        debugPrint('$email : $password');
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email ?? '', password: password ?? '')
        .then((value){
          if(value.user!.email != null){
            FirebaseAuth.instance.currentUser?.sendEmailVerification();
          }
          return value;
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password'){
          showToast('좀 더 강력한 패스워드를 작성하세요', context);
        }else if (e.code == 'email-already-in-use'){
          showToast('이미 등록된 이메일입니다.', context);
        }else{
          showToast('other error ${e.toString()}', context);
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    signIn() async {
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email ?? '', password: password ?? '')
        .then((value){
          debugPrint(value.toString());
          if (value.user!.emailVerified){
            // 이메일 인증됨
            showToast('환영합니다 ${email?.split('@')[0]}님', context);
          }else{
            showToast('이메일이 인증되지 않았습니다.', context);
          }
          return value;
        });

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found'){
          showToast('사용자를 찾을 수 없습니다.', context);
        }else if (e.code == 'wrong-password'){
          showToast('패스워드가 틀렸습니다.', context);
        }else{
          showToast('other error ${e.toString()}', context);
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    signOut() async {
      try{
        await FirebaseAuth.instance.signOut(); // void 리턴이네? 
      } catch (e) {
        debugPrint(e.toString());
      }
      // 아무일 없으면 로그아웃한것으로 ~ ㅋ
      // 로그인 상태를 변경해줘야한다 TODO
    }

    // 로그인 되어있으면 확인창으로 아니면 로그인창으로 분기 코드 TODO
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('반가워요~^^'),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(10),
              // constraints: BoxConstraints(minWidth: 300, maxWidth: MediaQuery.of(context).size.width - 10, maxHeight: 200),
              constraints: BoxConstraints(maxWidth: 300, maxHeight: 200),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      initialValue: Preferences.getString('email'),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return '이메일을 적으세요.';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        email = newValue ?? '';
                        Preferences.setString('email', newValue ?? '');
                      }
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      initialValue: Preferences.getString('password'),
                      obscureText: true,
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return '패스워드를 적으세요.';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        password = newValue ?? '';
                        Preferences.setString('password', newValue ?? '');
                      }
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        signUp();
                      }
                    },
                    child: const Text('가입')),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        signIn();
                      }
                    },
                    child: const Text('로그인')),
              ),
            ],
          ),
          // Row(children: [
          //   Text('이메일'),
          //   input
          // ],), // 이메일
          // Row(), // 패스워드
          // Row(), // 가입, 로그인
        ],
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: getPrefs(),
  //     builder: (context, snapshot) {
  //       // if(snapshot.hasData){
  //       //   setState(() {
  //       //     email = snapshot.data?.getString('email') ?? '';
  //       //     password = snapshot.data?.getString('password') ?? '';
  //       //   });
  //       // }

  //       return Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           // crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             const Text('반가워요~^^'),
  //             Flexible(
  //               child: Container(
  //                 padding: EdgeInsets.all(10),
  //                 // constraints: BoxConstraints(minWidth: 300, maxWidth: MediaQuery.of(context).size.width - 10, maxHeight: 200),
  //                 constraints: BoxConstraints(maxWidth: 300, maxHeight: 200),
  //                 child: Form(
  //                   key: _formKey,
  //                   child: Column(
  //                     children: [
  //                       TextFormField(
  //                         decoration: const InputDecoration(labelText: 'Email'),
  //                         initialValue: email,
  //                         validator: (value) {
  //                           if (value?.isEmpty ?? false) {
  //                             return '이메일을 적으세요.';
  //                           }
  //                           return null;
  //                         },
  //                         onSaved: (newValue) => email = newValue ?? '',
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       TextFormField(
  //                         decoration:
  //                             const InputDecoration(labelText: 'Password'),
  //                         initialValue: password,
  //                         obscureText: true,
  //                         validator: (value) {
  //                           if (value?.isEmpty ?? false) {
  //                             return '패스워드를 적으세요.';
  //                           }
  //                           return null;
  //                         },
  //                         onSaved: (newValue) => password = newValue ?? '',
  //                       ),
  //                       SizedBox(
  //                         height: 30,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   margin: const EdgeInsets.all(8),
  //                   child: ElevatedButton(
  //                       onPressed: () async {
  //                         if (_formKey.currentState?.validate() ?? false) {
  //                           _formKey.currentState?.save();
  //                           showToast('email : $email \r\npasswod : $password',
  //                               context);
  //                           await prefs.setString('email', email ?? '');
  //                           await prefs.setString('password', password ?? '');
  //                         }
  //                       },
  //                       child: const Text('가입')),
  //                 ),
  //                 Container(
  //                   margin: const EdgeInsets.all(8),
  //                   child: ElevatedButton(
  //                       onPressed: () {
  //                         if (_formKey.currentState?.validate() ?? false) {
  //                           _formKey.currentState?.save();
  //                           showToast(
  //                               'email : ${prefs.getString('email')} \r\npasswod : ${prefs.getString('password')}',
  //                               context);
  //                         }
  //                       },
  //                       child: const Text('로그인')),
  //                 ),
  //               ],
  //             ),
  //             // Row(children: [
  //             //   Text('이메일'),
  //             //   input
  //             // ],), // 이메일
  //             // Row(), // 패스워드
  //             // Row(), // 가입, 로그인
  //           ],
  //         ),
  //       );
  //     },
  //   );
}
