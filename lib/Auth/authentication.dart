import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Authentication {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        

        
          DocumentSnapshot userDoc;
         
            userDoc = await users.doc(user!.email).get();
        

          // If the user doesn't exist in Firestore, add them
          if (!userDoc.exists) {
            
              try {
                
                print(user.email);
                await users.doc(user.email).set({
                  'uid': user.uid,
                  'displayName': user.displayName,
                  'email': user.email,
                  'availability': 'Permanant',
                  'specialization': 'Plumbing',
                  'addharImage': '',
                  'profilePhoto': '',
                  // Add other user information you want to store
                });
              } catch (e) {
                customSnackBar(content: e.toString());
              }
           
          } else {
            customSnackBar(content: "User exists");
          }
        }
       on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          customSnackBar(content: e.toString());
        } else if (e.code == 'invalid-credential') {
          customSnackBar(content: e.toString());
        }
      } catch (e) {
        customSnackBar(content: e.toString());
      }
    }

    return user;
  }
}

SnackBar customSnackBar({required String content}) {
  return SnackBar(
    backgroundColor: Colors.black,
    content: Text(
      content,
      style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
    ),
  );
}