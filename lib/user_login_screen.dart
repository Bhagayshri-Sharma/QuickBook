import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manageresume/user_data_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;

class UserLoginScreen extends StatelessWidget{
  const UserLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
  return const Scaffold(
    body: LoginPage(),
  );
  }
}

class LoginPage extends StatefulWidget{

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var error ='' ;

  final _textFormController = TextEditingController() ;
  final _passwordControllerone = TextEditingController() ;
  bool _buttonDisable = false ;
  var UsernameError = '';
  var passwordError = '' ;

  @override
  void dispose() {
    _textFormController.dispose();
    _passwordControllerone.dispose();
    super.dispose();
  }

  void verifyAccount() async{

    setState(() {
      _buttonDisable = true ;
    });

    final username = _textFormController.text ;
    final password = _passwordControllerone.text ;


    if(username.isEmpty){
      setState(() {
        UsernameError = 'Please enter your email address';
        _buttonDisable = false ;
      });

    }
    if(password.isEmpty){
      setState(() {
        passwordError = 'Please enter a password';
        _buttonDisable = false ;
      });

    }
    if (error.isEmpty){
      final payload = {
      "email": username,
      "password": password,
    } ;
      final url = Uri.http('rachanasharma.pythonanywhere.com', '/token/');
      final response = await http.post(url, body: payload);
      final userData = jsonDecode(response.body);
      addStringToSF() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('access', userData['access']);
        prefs.setString('refresh', userData['refresh']);
      }
      if (userData.containsKey('detail')) {
        setState(() {
          error = userData['detail'] ;
          _buttonDisable = false ;
        });
      }
      if(userData.containsKey('access')){
        addStringToSF();
        setState(() {
          _buttonDisable = false ;
        });
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const UserDataScreen()));
      }
    }
     }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(text: const TextSpan(children: [TextSpan(text: "S", style: TextStyle(fontSize: 35, color: Colors.blueAccent, fontWeight: FontWeight.bold)), TextSpan(text: "ign In", style: TextStyle(fontSize: 30, color: Colors.black))], )),
          const SizedBox(height: 18,),
          TextFormField(
            controller:  _textFormController,
            decoration : const InputDecoration(label: Text('Enter email'), labelStyle: TextStyle(color: Colors.black), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black),),),
          ),
          Text(_textFormController.text.isEmpty ? UsernameError : '', style: const TextStyle(color: Colors.redAccent),),
          TextFormField(
            controller:  _passwordControllerone,
            decoration : const InputDecoration(label: Text('Enter Password'), labelStyle: TextStyle(color: Colors.black), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black),),),
          ),
          Text(_textFormController.text.isEmpty ? passwordError : '', style: const TextStyle(color: Colors.redAccent),),
          const SizedBox(height: 18,),
          SizedBox(width: double.infinity,child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), onPressed: _buttonDisable ? null : verifyAccount, child: const Text("Continue", style: TextStyle(fontSize: 20),)),),
          Text(error, style: const TextStyle(color: Colors.redAccent),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Not already registered ?"),
              TextButton(onPressed: (){}, child: const Text('Registered'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider( ),
              // Text('or'),
              // const Divider( ),
            ],
          )
        ],
      ),
    );
  }
}
