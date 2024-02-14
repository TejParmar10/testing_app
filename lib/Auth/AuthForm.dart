import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool isLoginPage=false;

  var _email='';
  final _formKey = GlobalKey<FormState>();
  var _password='';
  var _username='';
  doAuthentication(){
    final validity=_formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if(validity!=null){
      _formKey.currentState?.save();
      submitForm(_username,_email,_password);
    }
  }
submitForm(String username,String email,String passworrd)async{
final auth=FirebaseAuth.instance;
UserCredential authResult;
try{
  if(isLoginPage){
    authResult=await auth.signInWithEmailAndPassword(email: email, password: passworrd);
  }
  else{
    print("hELLP");
    authResult=await auth.createUserWithEmailAndPassword(email: email, password: passworrd);
    String uid=authResult.user!.uid; 
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'username':username,
      'email':email,
    });
    
  }
}
catch(err){
print(err);
}
}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          
          children: [
          Container(
            child: Form(key:_formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(!isLoginPage)
                // Username
                TextFormField(
              keyboardType: TextInputType.emailAddress,
              key:ValueKey('username'),
              validator: (value){
                if(value!.isEmpty){
                  return 'Please enter a username';
                }
                return null;
              },
              onSaved: (value){
                _username=value!;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Username',
                labelStyle: GoogleFonts.roboto(),
              ),
            ),
            SizedBox(height: 10,),
                 // EMail
                TextFormField(
              keyboardType: TextInputType.emailAddress,
              key:ValueKey('email'),
              validator: (value){
                if(value!.isEmpty || !value.contains('@')){
                  return 'Please enter a valid email address';
                }
                return null;
              },
              onSaved: (value){
                _email=value!;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Email Address',
                labelStyle: GoogleFonts.roboto(),
              ),
            ),
            SizedBox(height: 10,),       
            // Password
                 TextFormField(
                  obscureText: true,
              keyboardType: TextInputType.emailAddress,
              key:ValueKey('password'),
              validator: (value){
                if(value!.isEmpty){
                  return 'Please enter a password';
                }
                return null;
              },
              onSaved: (value){
                _password=value!;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: new BorderSide(),
                ),
                labelText: 'Password',
                labelStyle: GoogleFonts.roboto(),
              ),
            ),
            SizedBox(height: 10,),
              SizedBox(width: 200,child: ElevatedButton(onPressed: (){submitForm(_username, _email,_password);},child:isLoginPage? Text('Login',style: GoogleFonts.roboto(),):Text('SignUp',style: GoogleFonts.roboto(),),),),      
               SizedBox(height: 10,),
               Container(child: TextButton(child: isLoginPage?Text('Not a Member?'):Text('Already a Member?'),onPressed: (){
                setState(() {
                  isLoginPage=!isLoginPage;
                });
               },),)
            ],
           
            ),
            
            ),
          )
        ],),
      ),
    );
  }
}