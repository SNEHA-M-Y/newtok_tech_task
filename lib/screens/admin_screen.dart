import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newtok_tech_task/screens/signin_screen.dart';
import 'package:newtok_tech_task/services/adminscreen_provider.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavigationDrawer(children: [
        ListTile(
          leading: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  );
                });
              },
              icon: Icon(Icons.logout_outlined)),
          title: Text("LogOut"),
        )
      ]),
      backgroundColor: const Color.fromARGB(137, 237, 208, 208),
      appBar: AppBar(
        leading: Icon(
          Icons.admin_panel_settings_outlined,
          color: Colors.black54,
          size: 35,
        ),
        backgroundColor: Colors.cyan,
        title: Text(
          "Admin",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<AdminscreenProvider>(
        builder: (context, providerlocationvalue, child) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                CSCPicker(
                  onCountryChanged: (value) {
                    providerlocationvalue.countryValue = value.toString();
                  },
                  onStateChanged: (value) {
                    providerlocationvalue.stateValue = value.toString();
                  },
                  onCityChanged: (value) {
                    providerlocationvalue.cityValue = value.toString();
                    providerlocationvalue.locationAccess();
                  },
                ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text:
                              "${providerlocationvalue.countryValue},${providerlocationvalue.stateValue},${providerlocationvalue.cityValue}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                    onPressed: () {
                      providerlocationvalue.locationAccess();
                      FirebaseFirestore.instance
                          .collection("locations")
                          .doc(providerlocationvalue.cityValue)
                          .set(providerlocationvalue.addLocationAccess,
                              SetOptions(merge: true));
                    },
                    child: Text("Upload location to Web"))
              ],
            ),
          );
        },
      ),
    );
  }
}
