import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

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
      backgroundColor: backgroundColor,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: backgroundColor,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: backgroundColor),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[upperPart()],
            ),
          ),
        ),
      ),
    );
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
              padding: EdgeInsets.only(top: size.getWidthPx(36)),
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.getWidthPx(10)),
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
          height: size.getWidthPx(200),
          child: Column(
            children: <Widget>[
              // _searchWidget(),
              SizedBox(height: 10.0),
              leftAlignText(
                  text: "100",
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
                    "Kamu membutuhkan minimal 380 Poin untuk dapat menukarkan poin",
                leftPadding: size.getWidthPx(16),
                textColor: textPrimaryColor,
                fontSize: 16.0,
              ),
              SizedBox(height: 10.0),
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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ThemeHelper().alartDialog(
                    "Berhasil",
                    "Anda berhasil request penukaran poin silahkan kunjungi Bank Sampah kami",
                    context);
              },
            );
          }),
    );
  }
}
