import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rushbin/ui/page_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'package:rushbin/api.dart';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';

class PoinPage extends StatefulWidget {
  @override
  _PoinPageState createState() => _PoinPageState();
}

class _PoinPageState extends State<PoinPage> {
  String point = "";
  String idPengguna = "";
  DateTime jam1 =DateTime.now();

  int _selectedIndex = 0;

  Future getkode() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      point = (prefs.getString('point') ?? "");
      idPengguna = (prefs.getString('id_pengguna') ?? "");
    });
  }
  Screen size;

  @override
  void initState() {
    super.initState();
    getkode();
  }

  Future<void> tambah() async {
      var url = Uri.parse("${fire.URL_API}/tukar.php");
      var response = await http.post(url, body: {
        "tanggal": DateTime.now().toString(),
        "jam": "${jam1.hour}:${jam1.minute}:${jam1.second}",
        "idPengguna": idPengguna,
        "point": point
      });
      var dataAwal = jsonEncode(response.body);
      var dataJadi = jsonDecode(dataAwal);
      // print(dataJadi);
      if (dataJadi == "gagal") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Maaf point anda kurang")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Berhasil")),
        );
        
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: backgroundColor,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: backgroundColor),
            child: SafeArea(
              top: true,
              bottom: false,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[upperPart()],
            ),
          ),
        ),
      ),
    ));
  }

  Widget upperPart() {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: UpperClipper(),
          child: Container(
            height: size.getWidthPx(240),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorCurve, colorCurveSecondary],
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: size.getWidthPx(10)),
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.getWidthPx(10)),
                  Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          SizedBox(width: size.getWidthPx(10)),
                          Text("Tukar Poin", style: TextStyle(fontFamily: "Exo2", fontSize: 24, color: Colors.white),),
                        ],
                      ),
                      SizedBox(height: size.getWidthPx(24),),
                  upperBoxCard(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Card upperBoxCard() {
    return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(
            horizontal: size.getWidthPx(20), vertical: size.getWidthPx(16)),
        borderOnForeground: true,
        child: Container(
          height: size.getWidthPx(275),
          child: Column(
            children: <Widget>[
              // _searchWidget(),
              SizedBox(height: 10.0),
              leftAlignText(
                  text: point,
                  leftPadding: size.getWidthPx(16),
                  textColor: textPrimaryColor,
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold),
              SizedBox(height: 10.0),
              leftAlignText(
                  text: "Poin saat ini",
                  leftPadding: size.getWidthPx(16),
                  textColor: textPrimaryColor,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 10.0,
              ),
              leftAlignText(
                text:
                    "Kamu membutuhkan minimal 500 Poin untuk dapat menukarkan poin",
                leftPadding: size.getWidthPx(16),
                textColor: textPrimaryColor,
                fontSize: 16.0,
              ),
              SizedBox(height: 30.0),
              _poinButtonWidget(),
            ],
          ),
        ));
  }

  Container _poinButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(20), horizontal: size.getWidthPx(60)),
      width: size.getWidthPx(500),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: colorCurve,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
          child: Text(
            "Request Tukar Poin",
            style: TextStyle(
                fontFamily: 'Exo2', color: Colors.white, fontSize: 20.0),
          ),
          onPressed: () {
            tambah();
          }),
    );
  }
}
