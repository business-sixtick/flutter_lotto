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

  // late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    // getPrefs();
  }

  // getPrefs() async {
  //   prefs = await SharedPreferences.getInstance().then((onValue) {
  //     setState(() {
  //       email = onValue.getString('email') ?? '';
  //       password = onValue.getString('password') ?? '';
  //     });
  //     return onValue;
  //   });
  // }

  signUp() async {
    // try{
    //   await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
    // }
  }

  @override
  Widget build(BuildContext context) {
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
                      onSaved: (newValue) => email = newValue ?? '',
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
                      onSaved: (newValue) => password = newValue ?? '',
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
                        showToast(
                            'email : $email \r\npasswod : $password', context);
                        await Preferences.setString('email', email ?? '');
                        await Preferences.setString('password', password ?? '');
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
                        showToast(
                            'email : ${Preferences.getString('email')} \r\npasswod : ${Preferences.getString('password')}',
                            context);
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
