import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newtok_tech_task/reusable_widgets/reusable_widgets.dart';
import 'package:newtok_tech_task/screens/admin_screen.dart';
import 'package:newtok_tech_task/screens/signup_screen.dart';
import 'package:newtok_tech_task/screens/user_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blueGrey,
            const Color.fromARGB(255, 186, 71, 206)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  reusableTextFormfield("Enter Your Mail ID",
                      Icons.mail_outline, false, _emailTextController, (value) {
                    if (value!.isEmpty) {
                      return "Email cannot be empty";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please enter a valid email");
                    } else {
                      return null;
                    }
                  }, (value) {
                    _emailTextController.text = value!;
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextFormfield(
                    "Enter Password",
                    Icons.lock_outline,
                    false,
                    _passwordTextController,
                    (value) {
                      RegExp regex = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      if (!regex.hasMatch(value)) {
                        return ("please enter valid password min. 6 character");
                      } else {
                        return null;
                      }
                    },
                    (value) {
                      _passwordTextController.text = value!;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  signInSignupButton(context, true, () {
                    // FirebaseAuth.instance
                    //     .signInWithEmailAndPassword(
                    //         email: _emailTextController.text,
                    //         password: _passwordTextController.text)
                    //     .then((onValue) {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => UserScreen(),
                    //     ),
                    //   );
                    // }).onError((error, stackTrace) {
                    //   log("Error ${error.toString()}");
                    // });
                    signIn(context, _emailTextController.text,
                        _passwordTextController.text);
                  }),
                  signUpOption()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void route(BuildContext context) {
    log("---------");
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapShot) {
      if (documentSnapShot.exists) {
        if (documentSnapShot.get('userOrAdmin') == "Admin") {
          log("*****");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdminScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserScreen(),
            ),
          );
        }
      } else {
        log("Document Doese not Exist..");
      }
    });
  }

  void signIn(BuildContext context, String email, String password) async {
    log("sign in");
    if (_formkey.currentState!.validate()) {
      try {
        log("1");
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        log("2");

        route(context);
        log("3");
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          log('No User Found', name: "FireBase");
        } else if (e.code == "wrong-password") {
          log("Wrong Password", name: "Firebase");
        }
      }
    }
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't Have an Account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpScreen(),
                ));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
