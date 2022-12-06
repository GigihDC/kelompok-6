import 'package:flutter/material.dart';
import '../utils/utils.dart';

class PickupPage extends StatefulWidget {
  @override
  _PickupPageState createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  Screen size;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Pickup",
              style: TextStyle(fontFamily: "Exo2", color: backgroundColor)),
          backgroundColor: colorCurve,
        ),
        body: Center(
            child: Container(
                width: size.getWidthPx(300),
                height: size.getWidthPx(300),
                child: Image.asset("icons/icn_coming_soon.png"))));
  }
}
