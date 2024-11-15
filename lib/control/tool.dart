import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showToast(String massage, BuildContext context){
  FlutterToastr.show(
    massage, 
    context, 
    // duration: FlutterToastr.lengthShort, 
    duration: 3,
    position:  FlutterToastr.bottom,
    backgroundColor: Colors.amber[100] ?? const Color(0xfffce1ac),
    textStyle: const TextStyle(color: Colors.black),
    );
}


class Preferences{
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    if (_prefs != null) return;
    _prefs = await SharedPreferences.getInstance();
  }
  
  static String? getString(String key){
    return _prefs?.getString(key);
  }

  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

}
