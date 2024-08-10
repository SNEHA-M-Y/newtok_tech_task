import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newtok_tech_task/screens/signin_screen.dart';
import 'package:newtok_tech_task/services/userscreen_provider.dart';
import 'package:newtok_tech_task/services/weather_data_provider.dart';
import 'package:newtok_tech_task/widgets/cloud_location_access.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavigationDrawer(
        children: [
          ListTile(
              leading: Icon(
                Icons.upload_file_outlined,
                color: Colors.black,
                size: 35,
              ),
              title: Text("Access Data From Cloud"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CloudLocationAccess(),
                    ));
              }),
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
            title: Text("Sign out"),
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              });
            },
          )
        ],
      ),
      appBar: AppBar(
        title: Text(
          "User",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.cyan,
      ),
      backgroundColor: Color.fromARGB(255, 243, 222, 222),
      body: Consumer<UserscreenProvider>(
        builder: (context, screenvalue, child) {
          return Consumer<WeatherDataModelProvider>(
            builder: (context, weathervalue, child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: ElevatedButton(
                      onPressed: () {
                        screenvalue.pickfile();
                        log("-----");
                      },
                      child: Text(
                        "Choose Files",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                    ),
                  ),
                  Column(
                    children: [
                      const ListTile(
                        leading: Text("Sl.No",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black)),
                        title: Text("City",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black)),
                        trailing: Text("Weather",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black)),
                      ),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // var listLength =
                            //      weathervalue.weatherList.length ??= 0;
                            // }
                            if (weathervalue.weatherList.length <
                                screenvalue.totalRow) {
                              weathervalue.fetchWeather(
                                  screenvalue.setlocation.elementAt(index));
                              weathervalue.weatherList.add(weathervalue
                                  .weatherData!.main!.temp
                                  .toString());
                              //i=screenvalue.totalRow;
                            }

                            var realIndex = index + 1;
                            if (screenvalue.setlocation.isNotEmpty) {
                              return ListTile(
                                  leading: Text(realIndex.toString()),
                                  title: Text(
                                      screenvalue.setlocation.elementAt(index)),
                                  trailing:
                                      Text(weathervalue.weatherList[index]));
                            } else {
                              return const SizedBox();
                            }
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: screenvalue.totalRow)
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
