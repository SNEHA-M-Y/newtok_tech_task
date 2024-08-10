import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newtok_tech_task/firebase_options.dart';
import 'package:newtok_tech_task/screens/signin_screen.dart';
import 'package:newtok_tech_task/services/adminscreen_provider.dart';
import 'package:newtok_tech_task/services/registration_provider.dart';
import 'package:newtok_tech_task/services/userscreen_provider.dart';
import 'package:newtok_tech_task/services/weather_data_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegistrationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdminscreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserscreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeatherDataModelProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: const SignInScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
