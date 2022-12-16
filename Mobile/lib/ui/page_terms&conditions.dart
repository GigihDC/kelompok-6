import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

class TermsConditionPage extends StatefulWidget {
  @override
  _TermsConditionPageState createState() => _TermsConditionPageState();
}

class _TermsConditionPageState extends State<TermsConditionPage> {
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
          title: Text("Terms and Conditions",
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
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: size.getWidthPx(36), right: size.getWidthPx(16)),
              child: Column(
                children: <Widget>[
                  leftAlignText(
                    text:
                        "         Selamat datang di aplikasi Rushbin. ketentuan layanan ini mengatur penggunaan Rushbin itu sendiri. Kami memilki hak untuk dapat mengubah, menambahkan atau mengurangi ketentuan tanpa persetujuan dari user. Kami menyarankan supaya anda secara berkala membaca dan mengerti ketentuan layanan Rushbin sebelum menggunakannya. ketika anda sudah memahami dan mengerti ketentuan privasi dan ketentuan penggunaan layanan Rushbin. Syarat dan ketentuan ini berlaku salama aplikasi Rushbin beroperasi.",
                    leftPadding: size.getWidthPx(16),
                    textColor: textPrimaryColor,
                    fontSize: 16.0,
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
