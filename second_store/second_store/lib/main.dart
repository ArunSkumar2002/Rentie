import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:second_store/constants/constants.dart';
import 'package:second_store/screens/authentication/phoneauth_screen.dart';
import 'package:second_store/screens/location_screen.dart';
import 'package:second_store/screens/login_screen.dart';
import 'package:second_store/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 5)),   

      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //if its connecting screen will go to splash screen//
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primaryColor: AppColors.mainColor, fontFamily: 'Lato'),
              home: SplashScreen());
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: AppColors.mainColor, fontFamily: 'Lato'),
            home: const LoginScreen(),
            routes: {
              LoginScreen.id: (context) =>  LoginScreen(),
              PhoneAuthScreen.id: (context) =>  PhoneAuthScreen(),
              LocationScreen.id: (context) =>  LocationScreen(),
            },
          );
        }
      },
    );
  }
}
