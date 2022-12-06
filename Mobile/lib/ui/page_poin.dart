import 'package:flutter/material.dart';
import '../utils/utils.dart';

class PoinPage extends StatefulWidget {
  @override
  _PoinPageState createState() => _PoinPageState();
}

class _PoinPageState extends State<PoinPage> {
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
            elevation: 0.0,
            primary: false,
            title: Text("Tukar Poin",
                style: TextStyle(fontFamily: "Exo2", color: Colors.white)),
            backgroundColor: colorCurve,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Center(
            child: Container(
                width: size.getWidthPx(300),
                height: size.getWidthPx(300),
                child: Image.asset("icons/icn_coming_soon.png"))));
  }
}
