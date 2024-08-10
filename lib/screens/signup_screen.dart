import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newtok_tech_task/reusable_widgets/reusable_widgets.dart';
import 'package:newtok_tech_task/services/registration_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmpasswordTextController =
      TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              "Sign Up",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Color.fromARGB(255, 154, 151, 236),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "login as : ",
                    style: GoogleFonts.adventPro(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  DropdownButton<String>(
                    dropdownColor: Color.fromARGB(255, 143, 99, 237),
                    isDense: true,
                    isExpanded: false,
                    iconEnabledColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    focusColor: Colors.white,
                    items: value.choice.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(
                          dropDownStringItem,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (UpdatedChoiceselected) {
                      value.dropDownVariable(UpdatedChoiceselected);
                    },
                    value: value.choiceSelected,
                  )
                ],
              ),
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blueGrey,
                const Color.fromARGB(255, 186, 71, 206)
                /*
      
             define colours
            
             */
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      reusableTextFormfield(
                          "Enter your Email ID",
                          Icons.mail_outline,
                          false,
                          _emailTextController, (value) {
                        if (value!.isEmpty) {
                          return "Email cannot be empty";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please enter a valid email");
                        } else {
                          return null;
                        }
                      }, () {}),
                      SizedBox(
                        height: 20,
                      ),
                      reusableTextFormfield(
                          "Enter yor Password",
                          Icons.key_outlined,
                          false,
                          _passwordTextController, (value) //validator

                          {
                        RegExp regex = RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        if (!regex.hasMatch(value)) {
                          return ("please enter valid password min. 6 character");
                        } else {
                          return null;
                        }
                      }, () {} //onsaved

                          ),
                      SizedBox(
                        height: 20,
                      ),
                      reusableTextFormfield(
                          "Confirm Your PassWord",
                          Icons.lock_outlined,
                          false,
                          _confirmpasswordTextController, (value) {
                        if (_confirmpasswordTextController.text !=
                            _passwordTextController.text) {
                          return "Password did not match";
                        } else {
                          return null;
                        }
                      }, () {}),
                      SizedBox(
                        height: 20,
                      ),
                      signInSignupButton(
                        context,
                        false,
                        () {
                          // FirebaseAuth.instance
                          //     .createUserWithEmailAndPassword(
                          //         email: _emailTextController.text,
                          //         password: _passwordTextController.text)
                          //     .then((onValue) {
                          //   log("Created New Account");
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => UserScreen(),
                          //     ),
                          //   );
                          // }).onError((error, stackTrace) {
                          //   log("Error ${error.toString()}");
                          // });
                          signUp(
                              _scaffoldkey,
                              context,
                              _emailTextController.text,
                              _passwordTextController.text,
                              value.choiceSelected);
                          // log(_emailTextController.text);
                          // log(_passwordTextController.text);
                          // log(value.choiceSelected);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void signUp(var scaffoldKey, BuildContext context, String email,
      String password, String userOrAdmin) async {
    // const CircularProgressIndicator();
    log("_______");
    log(_formkey.currentState!.validate().toString());
    if (_formkey.currentState!.validate()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFirestore(scaffoldKey, context, email, userOrAdmin)
              })
          .catchError(
        (e) {
          return scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(e),
              duration: const Duration(seconds: 3),
            ),
          );
        },
      );
      log(email, name: "email");
      log(password, name: "password");
      log(userOrAdmin, name: "userOrAdmin");
    }
  }

  postDetailsToFirestore(var scaffoldKey, BuildContext context, String email,
      String userOrAdmin) async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref
        .doc(user!.uid)
        .set({'email': _emailTextController.text, 'userOrAdmin': userOrAdmin});
    // scaffoldKey.currentState
    //   .showSnackBar(const SnackBar(
    //     content: Text("Account Created"),
    //     duration: Duration(seconds: 3),
    //   ))
    //   .then((value) => Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }
}
