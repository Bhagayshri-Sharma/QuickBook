import 'package:flutter/material.dart';
import 'package:manageresume/user_login_screen.dart';
import 'package:manageresume/user_data_screen.dart';
import 'package:manageresume/create_resume_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var email=prefs.getString("access");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: email==null?const UserLoginScreen():const UserDataScreen(),));
}
