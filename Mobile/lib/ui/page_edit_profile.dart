import 'package:flutter/material.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'page_profile.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _lahirController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _lahirFocusNode = FocusNode();
  FocusNode _alamatFocusNode = FocusNode();
  String _name, _email, _lahir, _alamat;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
          title: Text("Edit Profile",
              style: TextStyle(fontFamily: "Exo2", color: Colors.white)),
          backgroundColor: colorCurve,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, false),
          )),
      resizeToAvoidBottomInset: true,
      body: Stack(children: <Widget>[
        ClipPath(
            clipper: UpperClipper(),
            child: Container(
              color: colorCurve,
            )),
        SingleChildScrollView(
            child: SafeArea(
          top: true,
          bottom: false,
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: size.getWidthPx(20), vertical: size.getWidthPx(20)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: colorCurve,
                        ),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                      // SizedBox(width: size.getWidthPx(10)),
                      // _signUpGradientText(),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 60),
                    child: Column(children: <Widget>[
                      SafeArea(
                        child: CircleAvatar(
                          foregroundColor: backgroundColor,
                          maxRadius: 50,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: Colors.grey.shade300,
                            size: 80.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                        child: Icon(
                          Icons.add_circle,
                          color: Colors.grey.shade700,
                          size: 25.0,
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: size.getWidthPx(10)),
                  // _textAccount(),
                  // SizedBox(height: size.getWidthPx(30)),
                  registerFields()
                ]),
          ),
        ))
      ]),
    );
  }

  BoxField _nameWidget() {
    return BoxField(
        controller: _nameController,
        focusNode: _nameFocusNode,
        hintText: "Enter Name",
        lableText: "Name",
        obscureText: false,
        onSaved: (String val) {
          _name = val;
        },
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_lahirFocusNode);
        },
        icon: Icons.person,
        iconColor: colorCurve);
  }

  BoxField _emailWidget() {
    return BoxField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        hintText: "Enter email",
        lableText: "Email",
        obscureText: false,
        onSaved: (String val) {
          _email = val;
        },
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_nameFocusNode);
        },
        icon: Icons.email,
        iconColor: colorCurve);
  }

  BoxField _lahirWidget() {
    return BoxField(
        controller: _lahirController,
        focusNode: _lahirFocusNode,
        hintText: "Enter Password",
        lableText: "Password",
        obscureText: true,
        icon: Icons.lock_outline,
        onSaved: (String val) {
          _lahir = val;
        },
        iconColor: colorCurve);
  }

  BoxField _alamatWidget() {
    return BoxField(
        controller: _alamatController,
        focusNode: _alamatFocusNode,
        hintText: "Enter Confirm Password",
        lableText: "Confirm Password",
        obscureText: true,
        icon: Icons.lock_outline,
        onSaved: (String val) {
          _alamat = val;
        },
        iconColor: colorCurve);
  }

  Container _saveButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)),
      width: size.getWidthPx(200),
      child: ElevatedButton(
        // elevation: 8.0,
        style: ElevatedButton.styleFrom(
            backgroundColor: colorCurve,
            foregroundColor: colorCurveSecondary,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))),
        // padding: EdgeInsets.all(size.getWidthPx(12)),
        child: Text(
          "Save",
          style: TextStyle(
              fontFamily: 'Exo2', color: Colors.white, fontSize: 20.0),
        ),
        // color: colorCurve,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
          // Going to DashBoard
        },
      ),
    );
  }

  registerFields() => Container(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _emailWidget(),
                _nameWidget(),
                _lahirWidget(),
                _alamatWidget(),
                _saveButtonWidget(),
              ],
            )),
      );
}
