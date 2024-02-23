import 'package:firebase_core/firebase_core.dart';
import 'package:firebaselogin/login_page.dart';
import 'package:firebaselogin/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebaselogin/firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    ),
  );
}