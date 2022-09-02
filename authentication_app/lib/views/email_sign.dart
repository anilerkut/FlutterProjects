import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

enum FormStatus { signIn, register, reset }

class EmailSign extends StatefulWidget {
  const EmailSign({Key? key}) : super(key: key);

  @override
  State<EmailSign> createState() => _EmailSignState();
}

class _EmailSignState extends State<EmailSign> {
  FormStatus _formStatus = FormStatus.signIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _formStatus == FormStatus.signIn
            ? signInForm()
            : _formStatus == FormStatus.register
                ? registerForm()
                : forgotPasswordForm(),
      ),
    );
  }

  Widget signInForm() {
    final _signInFormKey = GlobalKey<FormState>();
    TextEditingController _emailSignController = TextEditingController();
    TextEditingController _passwordSignController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _signInFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please Log in",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailSignController,
              validator: (value) {
                if (value != null) {
                  if (!EmailValidator.validate(value)) {
                    return "Enter Valid Email";
                  } else {
                    return null;
                  }
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Enter Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _passwordSignController,
              validator: (value) {
                if (value != null) {
                  if (value.length < 6)
                    return "Password must be longer than 6 characters";
                  else
                    return null;
                }
              },
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Enter Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  if (_signInFormKey.currentState?.validate() != null &&
                      _signInFormKey.currentState?.validate() == true) {
                    final user = await Provider.of<Auth>(context, listen: false)
                        .signInWithEmailAndPassword(_emailSignController.text,
                            _passwordSignController.text);
                    if (user != null && !user.emailVerified) {
                      await _showMyDialog();
                      await Provider.of<Auth>(context, listen: false).signOut();
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text("Enter")),
            TextButton(
                onPressed: () {
                  _formStatus = FormStatus.register;
                  setState(() {});
                },
                child: Text("Not a member?")),
            TextButton(
                onPressed: () {
                  _formStatus = FormStatus.reset;
                  setState(() {});
                },
                child: Text("Forgot Your Password?"))
          ],
        ),
      ),
    );
  }

  Widget registerForm() {
    final _registerFormKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _FirstpasswordController = TextEditingController();
    TextEditingController _SecondpasswordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value != null) {
                  if (!EmailValidator.validate(value)) {
                    return "Enter Valid Email";
                  } else {
                    return null;
                  }
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Enter Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _FirstpasswordController,
              validator: (value) {
                if (value != null) {
                  if (value.length < 6)
                    return "Password must be longer than 6 characters";
                  else
                    return null;
                }
              },
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Enter Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _SecondpasswordController,
              validator: (value) {
                if (value != _FirstpasswordController.text) {
                  return "Passwords do not match!";
                } else
                  return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Password Again",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  if (_registerFormKey.currentState?.validate() != null &&
                      _registerFormKey.currentState?.validate() == true) {
                    final user = await Provider.of<Auth>(context, listen: false)
                        .createUserWithEmailAndPassword(_emailController.text,
                            _FirstpasswordController.text);
                    if (user != null && !user.emailVerified) {
                      await user.sendEmailVerification();
                    }
                    await _showMyDialog();
                    await Provider.of<Auth>(context, listen: false).signOut();
                    setState(() {
                      _formStatus = FormStatus.signIn;
                    });
                  }
                },
                child: Text("Register")),
            TextButton(
                onPressed: () {
                  _formStatus = FormStatus.signIn;
                  setState(() {});
                },
                child: Text("Already Member?")),
          ],
        ),
      ),
    );
  }

  Widget forgotPasswordForm() {
    final _forgotPasswordFormKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _forgotPasswordFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Forgot Password",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value != null) {
                  if (!EmailValidator.validate(value)) {
                    return "Enter Valid Email";
                  } else {
                    return null;
                  }
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Enter Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  if (_forgotPasswordFormKey.currentState!.validate()) {
                    await Provider.of<Auth>(context, listen: false)
                        .sendPasswordResetEmail(_emailController.text);

                    await _showResetDialog();
                    Navigator.pop(context);
                  }
                },
                child: Text("Send")),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("ONAY GEREKİYOR"),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('<Merhaba Lütfen mailnizi kontrol ediniz'),
                Text('Onay Linkine tıklayıp tekrar giriş yapmalısnız'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anladım'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showResetDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("ŞİFRE YENİLEME"),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('<Merhaba Lütfen mailnizi kontrol ediniz'),
                Text('Linke tıklayarak şifrenizi yenileyiniz.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anladım'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
