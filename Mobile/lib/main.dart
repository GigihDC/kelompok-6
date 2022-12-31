import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rushbin/ui/page_home.dart';
import 'ui/page_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key key, this.isLoggedIn}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: isLoggedIn ? HomePage() : SplashScreen(),
    );
  }
}

class CollectionApp extends StatelessWidget {
  final bool isLoggedIn;
  const CollectionApp({Key key, this.isLoggedIn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Theme.of(context).primaryColor,
        ),
        home: SplashScreen(),
        );
  }
}
