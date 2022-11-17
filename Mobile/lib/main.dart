import 'package:flutter/material.dart';
import 'package:rushbin/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyBQYehzgRksB-ESj1dP4F_gk6pRE-aWspE',
          appId: '1:609579411770:android:fa9c32851939283f030803',
          messagingSenderId: '609579411770',
          projectId: 'login-2d5bf'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rushbin',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(title: 'Rushbin'),
      debugShowCheckedModeBanner: false,
    );
  }
}
