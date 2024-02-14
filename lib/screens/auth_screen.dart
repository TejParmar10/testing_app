import 'package:flutter/material.dart';
// import 'package:my_todo_app/Auth/AuthForm.dart';
import 'package:testing_app/Auth/AuthForm.dart';
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Authentication"),
      ),
      body: AuthForm(),
    );
  }
  }