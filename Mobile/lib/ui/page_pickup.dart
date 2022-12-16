import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

class PickupPage extends StatefulWidget {
  @override
  _PickupPageState createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  TextEditingController _addreesController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  FocusNode _addressFocusNode = new FocusNode();
  FocusNode _descFocusNode = new FocusNode();
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
        backgroundColor: backgroundColor,
        body: AnnotatedRegion(
            value: SystemUiOverlayStyle(
                statusBarColor: backgroundColor,
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: backgroundColor),
            child: Container(
              color: Colors.white,
              child: SafeArea(
                top: true,
                bottom: false,
                child: Stack(fit: StackFit.expand, children: <Widget>[
                  ClipPath(
                      clipper: BottomShapeClipper(),
                      child: Container(
                        color: colorCurve,
                      )),
                  SingleChildScrollView(
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.getWidthPx(20),
                            vertical: size.getWidthPx(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[upperPart()],
                        )),
                  ),
                ]),
              ),
            )));
  }

  Widget upperPart() {
    return Stack(
      children: <Widget>[
        Container(
            child: Column(children: <Widget>[
          leftAlignText(
              text: "Masukkan Foto Sampah yang akan diangkut",
              leftPadding: size.getWidthPx(16),
              textColor: textPrimaryColor,
              fontSize: 16.0),
          photoBox(),
          SizedBox(height: 10.0),
          leftAlignText(
              text: "Alamat",
              leftPadding: size.getWidthPx(16),
              textColor: textPrimaryColor,
              fontSize: 16.0),
          addressBox(),
          SizedBox(height: 10.0),
          leftAlignText(
              text: "Deskripsi",
              leftPadding: size.getWidthPx(16),
              textColor: textPrimaryColor,
              fontSize: 16.0),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(width: 420, child: descBox()),
        ]))
      ],
    );
  }

  Row photoBox() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: ButtonBar(children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: ElevatedButton(
                  child: Text('+'),
                  style: ElevatedButton.styleFrom(
                      primary: colorCurve,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(0),
                          )),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: ElevatedButton(
                  child: Text('+'),
                  style: ElevatedButton.styleFrom(
                      primary: colorCurve,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(0))),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: ElevatedButton(
                  child: Text('+'),
                  style: ElevatedButton.styleFrom(
                      primary: colorCurve,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(0))),
                  onPressed: () {},
                ),
              )
            ]),
          ),
        ]);
  }

  BoxField addressBox() {
    return BoxField(
        controller: _addreesController,
        focusNode: _addressFocusNode,
        hintText: "Masukkan Alamat",
        lableText: "Alamat",
        obscureText: false,
        icon: Icons.add_home,
        iconColor: colorCurve);
  }

  TextField descBox() {
    return TextField(
      controller: _descController,
      focusNode: _descFocusNode,
      decoration: InputDecoration(
          hintText: 'Masukkan Deskripsi',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
      maxLines: 10,
      minLines: 5,
    );
  }
}
