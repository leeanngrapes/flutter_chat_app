import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(String email, String userName, String password,
      bool isLogin, BuildContext ctx) async {
    UserCredential authResult;
    try {
      if (isLogin) {
        //Log the user in
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        //Create a new user
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
    } on FirebaseAuthException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}
