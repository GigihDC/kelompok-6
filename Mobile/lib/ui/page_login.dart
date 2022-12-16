import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rushbin/model/models.dart';
import 'package:rushbin/ui/page_dashboard.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'page_forgotpass.dart';
import 'page_home.dart';
import 'page_signup.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  FocusNode _emailFocusNode = new FocusNode();
  FocusNode _passFocusNode = new FocusNode();
  String _email, _password;
  bool _isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Screen size;

  bool isPasswordVisible = false;

  Future login() async {
    // var url = Uri.http("192.168.1.16", '/PHP2/login.php', {'q': '{http}'});
    // var response = await http.post(url, body: {
    //   "username": _emailController.text,
    //   "password": _passwordController.text,
    // });

    Uri url = Uri.parse(
        "http://192.168.1.16/PHP2/login.php?email=${_emailController.text.toString()}&password=${_passwordController.text.toString()}");
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    if (data.toString() == "Success") {
      Fluttertoast.showToast(
        msg: 'Login Successful',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Email and password invalid',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: true,
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle(
              statusBarColor: backgroundColor,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
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
                        children: <Widget>[
                          _loginGradientText(),
                          SizedBox(height: size.getWidthPx(10)),
                          _textAccount(),
                          SizedBox(height: size.getWidthPx(30)),
                          loginFields()
                        ]),
                  ),
                )
              ]),
            ),
          ),
        ));
  }

  RichText _textAccount() {
    return RichText(
      text: TextSpan(
          text: "Don't have an account? ",
          children: [
            TextSpan(
              style: TextStyle(color: Colors.deepOrange),
              text: 'Create your account.',
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage())),
            )
          ],
          style: TextStyle(
              color: Colors.black87, fontSize: 14, fontFamily: 'Exo2')),
    );
  }

  GradientText _loginGradientText() {
    return GradientText('Login',
        gradient: LinearGradient(colors: [
          Color.fromRGBO(97, 6, 165, 1.0),
          Color.fromRGBO(45, 160, 240, 1.0)
        ]),
        style: TextStyle(
            fontFamily: 'Exo2', fontSize: 36, fontWeight: FontWeight.bold));
  }

  TextFormField _emailWidget() {
    return TextFormField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        style: TextStyle(height: 1.5),
        decoration: InputDecoration(
            labelStyle: TextStyle(fontFamily: 'Exo2', color: textPrimaryColor),
            labelText: 'Email',
            hintText: 'Masukkan Email',
            prefixIcon: Icon(Icons.email, color: colorCurve),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: colorCurve))),
        obscureText: false,
        validator: (value) {
          if (value != null) {
            if (value.contains('@') && value.endsWith('.com')) {
              return null;
            }
            return 'Enter a Valid Email Address';
          }
          return null;
        },
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
            hintText: "Enter Password",
            labelText: "Password",
            labelStyle: TextStyle(fontFamily: 'Exo2', color: textPrimaryColor),
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
        obscureText: true,
        onSaved: (String val) {
          _password = val;
        });
  }

  Container _loginButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)),
      width: size.getWidthPx(200),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: colorCurve,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))),
        // elevation: 8.0,
        // padding: EdgeInsets.all(size.getWidthPx(12)),
        child: Text(
          "Login",
          style: TextStyle(
              fontFamily: 'Exo2', color: Colors.white, fontSize: 20.0),
        ),
        // color: colorCurve,
        // onPressed: () {
        //   Navigator.pushReplacement(context,
        //             MaterialPageRoute(builder: (context) => HomePage()));
        // }
        onPressed: () async {
          // Going to DashBoard
          if (_formKey.currentState.validate()) {
            Route route = MaterialPageRoute(builder: (context) => HomePage());
            Navigator.push(context, route);
            var result;
            if (result.uid = null) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(content: Text(result.code));
                  });
            }
          }
        },
      ),
    );
  }

  Row _socialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        socialCircleAvatar("icons/icnfb.png", () {}),
        SizedBox(width: size.getWidthPx(18)),
        socialCircleAvatar("icons/icn_twitter.png", () {}),
        SizedBox(width: size.getWidthPx(18)),
        socialCircleAvatar("icons/icngmail.png", () {}),
      ],
    );
  }

  GestureDetector socialCircleAvatar(String assetIcon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        maxRadius: size.getWidthPx(24),
        backgroundColor: Colors.transparent,
        child: Image.asset(assetIcon),
      ),
    );
  }

  loginFields() => Container(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(width: 420, child: _emailWidget()),
                SizedBox(height: size.getWidthPx(20)),
                SizedBox(width: 420, child: _passwordWidget()),
                SizedBox(height: size.getWidthPx(5)),
                GestureDetector(
                    onTap: () {
                      //Navigate to Forgot Password Screen...
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageForgotPassword()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: size.getWidthPx(8)),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("Forgot Password?",
                              style: TextStyle(
                                  fontFamily: 'Exo2',
                                  fontSize: 14.0,
                                  color: Colors.blueAccent.shade700))),
                    )),
                SizedBox(height: size.getWidthPx(8)),
                _loginButtonWidget(),
                SizedBox(height: size.getWidthPx(28)),
                Text(
                  "Or Login with",
                  style: TextStyle(
                      fontFamily: 'Exo2', fontSize: 16.0, color: Colors.grey),
                ),
                SizedBox(height: size.getWidthPx(12)),
                _socialButtons()
              ],
            )),
      );
}
