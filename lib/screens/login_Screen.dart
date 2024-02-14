// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:testing_app/Auth/authentication.dart';
import 'package:testing_app/screens/home_screen.dart';

void main() {
  runApp(LoginScreen());
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              SignInButton(
                Buttons.Google,
                onPressed: () {
                  // Add your Google sign-in logic here
                  // This is just a placeholder
                  print('Google Sign-in button pressed');
                  handleauthentication(
                    context
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  handleauthentication(BuildContext context) async {
    User? user = await Authentication.signInWithGoogle(context: context);

    if (user != null) {
      
      
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      
    }
  }
}