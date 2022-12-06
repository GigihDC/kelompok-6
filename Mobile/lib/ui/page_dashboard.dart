import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rushbin/widgets/utils_widget.dart';
import '../model/models.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'page_poin.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Screen size;
  int _selectedIndex = 1;

  List<Property> productList = List();
  // List<Property> featuredList = List();
  // var citiesList = [
  //   "Ahmedabad",
  //   "Mumbai",
  //   "Delhi ",
  //   "Chennai",
  //   "Goa",
  //   "Kolkata",
  //   "Indore",
  //   "Jaipur"
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productList
      ..add(Property(
          propertyName: "Botol Plastik",
          // propertyLocation: "Ahmedabad ",
          image: "product_1.jpg",
          propertyPrice: "Rp. 1000 / Kg"))
      ..add(Property(
          propertyName: "Botol Kaca",
          // propertyLocation: "Baroda ",
          image: "product_2.jpg",
          propertyPrice: "Rp. 1500 / Kg"))
      ..add(Property(
          propertyName: "Kaleng",
          // propertyLocation: "Pune ",
          image: "product_3.jpg",
          propertyPrice: "Rp. 1000 / Kg"))
      ..add(Property(
          propertyName: "Plastik Buram",
          // propertyLocation: "Mumbai ",
          image: "product_4.jpg",
          propertyPrice: "Rp. 1000 / Kg"))
      ..add(Property(
          propertyName: "Plastik Bening",
          // propertyLocation: "Mumbai ",
          image: "product_5.jpg",
          propertyPrice: "Rp. 1500 / Kg"))
      ..add(Property(
          propertyName: "Kertas",
          // propertyLocation: "Gandhinagar ",
          image: "product_6.jpg",
          propertyPrice: "Rp. 1000 / Kg"))
      ..add(Property(
          propertyName: "Kertas Duplex",
          // propertyLocation: "Pune ",
          image: "product_7.jpg",
          propertyPrice: "Rp. 500 / Kg"))
      ..add(Property(
          propertyName: "Kardus",
          // propertyLocation: "Ahmedabad ",
          image: "product_8.jpg",
          propertyPrice: "Rp. 2000 / Kg"));
    // ..add(Property(
    //     propertyName: "Velone City",
    //     // propertyLocation: "Mumbai ",
    //     image: "feature_1.jpg",
    //     propertyPrice: "11.5 Cr"))
    // ..add(Property(
    //     propertyName: "PabelBay",
    //     // propertyLocation: "Ahmedabad ",
    //     image: "hall_1.jpg",
    //     propertyPrice: "33.1 Cr"))
    // ..add(Property(
    //     propertyName: "Sapath Hexa Tower",
    //     // propertyLocation: "Ahmedabad",
    //     image: "feature_3.jpg",
    //     propertyPrice: "15.6 Cr"));
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
                  titleWidget(),
                  SizedBox(height: size.getWidthPx(10)),
                  upperBoxCard(),
                ],
              ),
            ),
            leftAlignText(
                text: "Product properties",
                leftPadding: size.getWidthPx(16),
                textColor: textPrimaryColor,
                fontSize: 16.0),
            HorizontalList(
              children: <Widget>[
                for (int i = 0; i < productList.length; i++)
                  propertyCard(productList[i])
              ],
            ),
            // leftAlignText(
            //     text: "Featured properties",
            //     leftPadding: size.getWidthPx(16),
            //     textColor: textPrimaryColor,
            //     fontSize: 16.0),
            // HorizontalList(
            //   children: <Widget>[
            //     for (int i = 0; i < premiumList.length; i++)
            //       propertyCard(premiumList.reversed.toList()[i])
            //   ],
            // )
          ],
        ),
      ],
    );
  }

  Text titleWidget() {
    return Text(
      "Welcome !!\nWould you like to trade?",
      style: TextStyle(
          fontFamily: 'Exo2',
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
          color: Colors.white),
      textAlign: TextAlign.center,
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
          height: size.getWidthPx(150),
          child: Column(
            children: <Widget>[
              // _searchWidget(),
              SizedBox(height: 10.0),
              leftAlignText(
                  text: "Your Poin :",
                  leftPadding: size.getWidthPx(16),
                  textColor: textPrimaryColor,
                  fontSize: 20.0),
              SizedBox(height: 10.0),
              leftAlignText(
                  text: "O Poin",
                  leftPadding: size.getWidthPx(16),
                  textColor: Colors.blue,
                  fontSize: 40.0),
              SizedBox(height: 90.0),
              GestureDetector(
                  onTap: () {
                    //Navigate to Forgot Password Screen...
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PoinPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: size.getWidthPx(8)),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("Tukar Poin  ->",
                            style: TextStyle(
                                fontFamily: 'Exo2',
                                fontSize: 14.0,
                                color: Colors.blueAccent.shade700))),
                  )),
              // HorizontalList(
              //   children: <Widget>[
              //     for (int i = 0; i < citiesList.length; i++)
              //       buildChoiceChip(i, citiesList[i])
              //   ],
              // ),
            ],
          ),
        ));
  }

  BoxField _searchWidget() {
    return BoxField(
        controller: TextEditingController(),
        focusNode: FocusNode(),
        hintText: "Select by city, area or locality.",
        lableText: "Search...",
        obscureText: false,
        onSaved: (String val) {},
        icon: Icons.search,
        iconColor: colorCurve);
  }

  Padding leftAlignText({text, leftPadding, textColor, fontSize, fontWeight}) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text ?? "",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Exo2',
                fontSize: fontSize,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor)),
      ),
    );
  }

  Card propertyCard(Property property) {
    return Card(
        elevation: 4.0,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        borderOnForeground: true,
        child: Container(
            height: size.getWidthPx(150),
            width: size.getWidthPx(180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0)),
                    child: Image.asset('${property.image}', fit: BoxFit.fill)),
                SizedBox(height: size.getWidthPx(8)),
                leftAlignText(
                    text: property.propertyName,
                    leftPadding: size.getWidthPx(8),
                    textColor: textPrimaryColor,
                    fontSize: 14.0),
                // leftAlignText(
                //     text: property.propertyLocation,
                //     leftPadding: size.getWidthPx(8),
                //     textColor: Colors.black54,
                //     fontSize: 12.0),
                SizedBox(height: size.getWidthPx(4)),
                leftAlignText(
                    text: property.propertyPrice,
                    leftPadding: size.getWidthPx(8),
                    textColor: colorCurve,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800),
              ],
            )));
  }

  Padding buildChoiceChip(index, chipName) {
    return Padding(
      padding: EdgeInsets.only(left: size.getWidthPx(8)),
      child: ChoiceChip(
        backgroundColor: backgroundColor,
        selectedColor: colorCurve,
        labelStyle: TextStyle(
            fontFamily: 'Exo2',
            color:
                (_selectedIndex == index) ? backgroundColor : textPrimaryColor),
        elevation: 4.0,
        padding: EdgeInsets.symmetric(
            vertical: size.getWidthPx(4), horizontal: size.getWidthPx(12)),
        selected: (_selectedIndex == index) ? true : false,
        label: Text(chipName),
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
    );
  }
}
