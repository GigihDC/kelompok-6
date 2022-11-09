import 'package:flutter/material.dart';
import 'drawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.redAccent.shade700,
        ),
        drawer: DrawerView(),
        body: Center(
          child: Text(
            'Welcome !!',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
