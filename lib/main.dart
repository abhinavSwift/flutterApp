import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:passenger_app/login/MapRoute.dart';
import 'package:passenger_app/login/WelcomeScreen.dart';
import 'package:passenger_app/login/deal.dart';
// import 'package:passenger_app/login/WelcomeScreen.dart';
import 'package:passenger_app/login/login.dart';
import 'package:passenger_app/login/profile.dart';
import 'package:passenger_app/login/setting.dart';
import 'package:passenger_app/login/signup.dart';
import 'package:passenger_app/wallet/card.dart';
import 'package:passenger_app/wallet/wallet.dart';
import 'package:passenger_app/provider/referals.dart';
import 'package:passenger_app/testingFile.dart';
import 'package:passenger_app/trip/myTrips.dart';

import 'firebase_options.dart';
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase SDK
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // routes: ,
      // initialRoute: FirebaseAuth.instance.currentUser != null ? '/login': '/WelcomeScreen',
      routes: {
        // '/':(context) => const Login(),
        // '/':(context) => const DistanceCalc(),
        // '/':(context) =>  const WelcomeScreen(),
        '/':(context) =>  WalletScreen(),
        // '/deal':(context) =>    const DealsScreen(),
      },
    );
  }
}
