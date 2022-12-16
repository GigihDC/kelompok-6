import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/utils.dart';
import '../LocalBindings.dart';
import 'page_home.dart';
import 'page_login.dart';
import 'page_onboarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Screen size;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      navigateFromSplash();
    });
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
        backgroundColor: colorCurve,
        body: Center(
            child: Container(
                width: size.getWidthPx(250),
                height: size.getWidthPx(250),
                child: Image.asset("icons/logo_splash.png"))));
  }

  Future navigateFromSplash() async {
    String isOnBoard =
        await LocalStorage.sharedInstance.readValue(Constants.isOnBoard);
    print("isOnBoard  $isOnBoard");
    if (isOnBoard == null || isOnBoard == "0") {
      //Navigate to OnBoarding Screen.
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoardingPage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}
