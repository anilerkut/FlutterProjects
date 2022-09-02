import 'package:authentication_app/views/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../views/home_page.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  bool _isLogged = true;

  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        _isLogged = false;
        print('User is currently signed out!');
      } else {
        _isLogged = true;
        print('User is signed in!');
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLogged == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : _isLogged
            ? HomePage()
            : SignInPage();
  }
}
