import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/firebase_options.dart';
import 'package:testing_app/firebase_services.dart';
import 'package:testing_app/screens/auth_screen.dart';
import 'package:testing_app/screens/home_screen.dart';
import 'package:testing_app/screens/login_Screen.dart';
late final FirebaseApp app;
late final FirebaseAuth auth;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app=await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCSjoTx0a1R5e2X6F8UvIFHbcNB26sKMd0",
      appId: "1:824690229854:android:3a8d2159749f1708a7aacf",
      messagingSenderId: "824690229854",
      projectId: "deep-b87b0",
    ),
  );
auth = FirebaseAuth.instanceFor(app: app);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: 
        // if(usersnapshot.hasData){
        //   return HomeScreen();
        // }
        // else{
          // return 
          //
           LoginScreen()
      //   }
      // },
    );
  }
}



