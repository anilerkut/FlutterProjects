import 'package:authentication_app/views/email_sign.dart';
import 'package:authentication_app/widgets/my_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await Provider.of<Auth>(context, listen: false).signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign in Page",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 30),
            MyElevatedButton(
                textChild: Text("Sign In Anonymously"),
                onPressedMethod: () async {
                  final user = await Provider.of<Auth>(context, listen: false)
                      .signInAnonymously();
                }),
            SizedBox(height: 10),
            MyElevatedButton(
                textChild: Text("Email/Password Sign In"),
                onPressedMethod: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EmailSign()));
                }),
            SizedBox(height: 10),
            MyElevatedButton(
                textChild: Text("Google Sign In"),
                onPressedMethod: () async {
                  final user = await Provider.of<Auth>(context, listen: false)
                      .signInWithGoogle();
                }),
          ],
        ),
      ),
    );
  }
}
