import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rushbin/ui/page_login.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rushbin/api.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passFocusNode = FocusNode();
  FocusNode _confirmPassFocusNode = FocusNode();
  String _name, _email, _password, _confirmPassword;
  bool _isObscure = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Screen size;

  Future<void> _register() async {
    Uri url =
        Uri.parse("${fire.URL_API}/register.php");
    var response = await http.post(url, body: {
      "username": _emailController.text,
      "password": _passwordController.text,
      "nama": _nameController.text,
      "role":"user"
    });
    var data = jsonDecode(response.body);
    if (data == "gagal") {
      Fluttertoast.showToast(
          msg: "User ini sudah ada",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } else
      Fluttertoast.showToast(
          msg: "Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white);
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: true,
        body: Stack(children: <Widget>[
          ClipPath(
              clipper: BottomShapeClipper(),
              child: Container(
                color: colorCurve,
              )),
          SingleChildScrollView(
            child: SafeArea(
              top: true,
              bottom: false,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.getWidthPx(20),
                    vertical: size.getWidthPx(20)),
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
                          SizedBox(width: size.getWidthPx(10)),
                          _signUpGradientText(),
                        ],
                      ),
                      SizedBox(height: size.getWidthPx(10)),
                      _textAccount(),
                      SizedBox(height: size.getWidthPx(30)),
                      registerFields()
                    ]),
              ),
            ),
          )
        ]));
  }

  RichText _textAccount() {
    return RichText(
      text: TextSpan(
          text: "Apakah kamu sudah terdaftar? ",
          children: [
            TextSpan(
              style: TextStyle(color: Colors.deepOrange),
              text: 'Login disini',
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.pop(context),
            )
          ],
          style: TextStyle(
              fontFamily: 'Exo2', color: Colors.black87, fontSize: 18)),
    );
  }

  GradientText _signUpGradientText() {
    return GradientText('Register',
        gradient: LinearGradient(colors: [
          Color.fromRGBO(97, 6, 165, 1.0),
          Color.fromRGBO(45, 160, 240, 1.0)
        ]),
        style: TextStyle(
            fontFamily: 'Exo2', fontSize: 36, fontWeight: FontWeight.bold));
  }

  TextFormField _nameWidget() {
    return TextFormField(
        controller: _nameController,
        focusNode: _nameFocusNode,
        style: TextStyle(height: 1.5),
        decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 24, fontFamily: 'Exo2', color: textPrimaryColor),
            labelText: 'Nama',
            hintText: 'Masukkan Nama',
            prefixIcon: Icon(Icons.person, color: colorCurve),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: colorCurve))),
        obscureText: false,
        onSaved: (String val) {
          _name = val;
        },
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_emailFocusNode);
        });
  }

  TextFormField _emailWidget() {
    return TextFormField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        style: TextStyle(height: 1.5),
        decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 24, fontFamily: 'Exo2', color: textPrimaryColor),
            labelText: 'Email',
            hintText: 'Masukkan Email',
            prefixIcon: Icon(Icons.email, color: colorCurve),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: colorCurve))),
        obscureText: false,
        onSaved: (String val) {
          _email = val;
        },
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_passFocusNode);
        });
  }

  TextFormField _passwordWidget() {
    return TextFormField(
        controller: _passwordController,
        focusNode: _passFocusNode,
        style: TextStyle(height: 1.5),
        decoration: InputDecoration(
            hintText: "Masukkan Password",
            labelText: "Password",
            labelStyle: TextStyle(fontSize: 24, fontFamily: 'Exo2', color: textPrimaryColor),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: colorCurve,
            ),
            suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                }),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: colorCurve))),
        obscureText: _isObscure ? false : true,
        onSaved: (String val) {
          _password = val;
        });
  }

  TextFormField _confirmPasswordWidget() {
    return TextFormField(
        controller: _confirmPasswordController,
        focusNode: _confirmPassFocusNode,
        style: TextStyle(height: 1.5),
        decoration: InputDecoration(
            hintText: "Confirm Password",
            labelText: "Confirm Password",
            labelStyle: TextStyle(fontSize: 24, fontFamily: 'Exo2', color: textPrimaryColor),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: colorCurve,
            ),
            suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                }),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: colorCurve))),
        obscureText: _isObscure ? false : true,
        onSaved: (String val) {
          _confirmPassword = val;
        });
  }

  Container _signUpButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)),
      width: size.getWidthPx(200),
      child: ElevatedButton(
        // elevation: 8.0,
        style: ElevatedButton.styleFrom(
            primary: colorCurve,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))),
        // padding: EdgeInsets.all(size.getWidthPx(12)),
        child: Text(
          "Sign Up",
          style: TextStyle(
              fontFamily: 'Exo2', color: Colors.white, fontSize: 20.0),
        ),
        // color: colorCurve,
        onPressed: () {
          _register();
        },
      ),
    );
  }

  // GestureDetector socialCircleAvatar(String assetIcon, VoidCallback onTap) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: CircleAvatar(
  //       maxRadius: size.getWidthPx(20),
  //       backgroundColor: Colors.white,
  //       child: Image.asset(assetIcon),
  //     ),
  //   );
  // }

  registerFields() => Container(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _nameWidget(),
                SizedBox(height: size.getWidthPx(12),),
                _emailWidget(),
                SizedBox(height: size.getWidthPx(12),),
                _passwordWidget(),
                SizedBox(height: size.getWidthPx(12),),
                _confirmPasswordWidget(),
                SizedBox(height: size.getWidthPx(28),),
                _signUpButtonWidget(),
              ],
            )),
      );
}
