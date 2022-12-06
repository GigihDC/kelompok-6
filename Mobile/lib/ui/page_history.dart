import 'package:flutter/material.dart';
import '../utils/utils.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
          title: Text("History",
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
