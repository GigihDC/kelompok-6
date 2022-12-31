import 'dart:convert';
import 'dart:async';
import 'package:rushbin/api.dart';
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
import 'page_splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isObscure = false;
  bool _visible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Screen size;

  bool isPasswordVisible = true;
  Future userLogin() async {
    //Login API URL
    //use your local IP address instead of localhost or use Web API
    String url = "${fire.URL_API}/login.php";

    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    // Getting username and password from Controller
    var data = {
      'username': _emailController.text,
      'password': _passwordController.text,
    };

    //Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    if (response.statusCode == 200) {
      //Server response into variable
      print(response.body);
      var msg = jsonDecode(response.body);

      //Check Login Status
      if (msg['loginStatus'] == true) {
        setState(() {
          loginMessage("Berhasil Login");
          //hide progress indicator
          _visible = false;
        });
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);

        await prefs.setString(
          'username',
          msg['userInfo']['username'],
        );

        await prefs.setString(
          'id_pengguna',
          msg['userInfo']['id_pengguna'],
        );

        await prefs.setString(
          'nama_lengkap',
          msg['userInfo']['nama_lengkap'],
        );

        await prefs.setString(
          'telepon',
          msg['userInfo']['telepon'],
        );

        await prefs.setString(
          'alamat1',
          msg['userInfo']['alamat1'],
        );

        await prefs.setString(
          'alamat2',
          msg['userInfo']['alamat2'],
        );

        await prefs.setString(
          'alamat3',
          msg['userInfo']['alamat3'],
        );

        await prefs.setString(
          'point',
          msg['userInfo']['point'],
        );

        await prefs.setString(
          'password',
          msg['userInfo']['password'],
        );
        // Navigate to Home Screen
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        setState(() {
          //hide progress indicator
          _visible = false;

          //Show Error Message Dialog
          showMessage(msg["message"]);
        });
      }
    } else {
      setState(() {
        //hide progress indicator
        _visible = false;

        //Show Error Message Dialog
        showMessage("Error during connecting to Server.");
      });
    }
  }

  // Future<void> _login() async {
  //     Uri url = Uri.parse(
  //         "http://192.168.1.9/automation/api/login.php?username=${_emailController.text.toString()}&password=${_passwordController.text.toString()}");
  //     var response = await http.get(url);

  //     if (response.statusCode == 200) {
        
  //       print(response.body);
  //       var msg = jsonDecode(response.body);
        
  //       if (msg['loginStatus'] == true) {
          
  //         final prefs = await SharedPreferences.getInstance();
  //         prefs.setBool('isLoggedIn', true);
          
  //         await prefs.setString('username', msg['userinfo']['username']);

  //         // Fluttertoast.showToast(
  //         //   msg: 'Login Successful',
  //         //   backgroundColor: Colors.green,
  //         //   textColor: Colors.white,
  //         //   toastLength: Toast.LENGTH_SHORT,
  //         // );

  //         setState(() {
  //           loginMessage("Berhasil Login");
  //         });
          
  //       } else {
  //         setState(() {
            
  //           showMessage(msg["message"]);

  //         });

  //         // Fluttertoast.showToast(
  //         //   backgroundColor: Colors.red,
  //         //   textColor: Colors.white,
  //         //   msg: 'Email and password invalid',
  //         //   toastLength: Toast.LENGTH_SHORT
  //         //   );
  //       }
  //     } else {
  //       setState(() {
  //         showMessage("Something is Wrong in Your Connection");
  //       });
  //       // Fluttertoast.showToast(
  //       //     backgroundColor: Colors.red,
  //       //     textColor: Colors.white,
  //       //     msg: 'Something Error in Your Connection',
  //       //     toastLength: Toast.LENGTH_SHORT
  //       //     );
  //     }      
  //   }

    Future<void> showMessage(String _msg) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(_msg),
          actions: <Widget>[
            TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> loginMessage(String _msg) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(_msg),
          actions: <Widget>[
            TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            
              },
            ),
          ],
        );
      },
    );
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
          text: "Belum punya akun? ",
          children: [
            TextSpan(
              style: TextStyle(color: Colors.deepOrange),
              text: 'Buat akun disini.',
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage())),
            )
          ],
          style: TextStyle(
              color: Colors.black87, fontSize: 18, fontFamily: 'Exo2')),
    );
  }

  GradientText _loginGradientText() {
    return GradientText('Login',
        gradient: LinearGradient(colors: [
          Color.fromRGBO(97, 6, 165, 1.0),
          Color.fromRGBO(45, 160, 240, 1.0)
        ]),
        style: TextStyle(
            fontFamily: 'Exo2', fontSize: 40, fontWeight: FontWeight.bold));
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
        onPressed: () {
          userLogin();
          // final isValidForm = _formKey.currentState.validate();
          // if (isValidForm) {
          //   _login();
          // } else {
          //   return null;
          // }
        },
      ),
    );
  }

  // Row _socialButtons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       socialCircleAvatar("assets/icons/icnfb.png", () {}),
  //       SizedBox(width: size.getWidthPx(18)),
  //       socialCircleAvatar("assets/icons/icn_twitter.png", () {}),
  //       SizedBox(width: size.getWidthPx(18)),
  //       socialCircleAvatar("assets/icons/icngmail.png", () {}),
  //     ],
  //   );
  // }

  // GestureDetector socialCircleAvatar(String assetIcon, VoidCallback onTap) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: CircleAvatar(
  //       maxRadius: size.getWidthPx(24),
  //       backgroundColor: Colors.transparent,
  //       child: Image.asset(assetIcon),
  //     ),
  //   );
  // }

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
                          child: Text("Lupa Password?",
                              style: TextStyle(
                                  fontFamily: 'Exo2',
                                  fontSize: 18.0,
                                  color: Colors.blueAccent.shade700))),
                    )),
                SizedBox(height: size.getWidthPx(28)),
                _loginButtonWidget(),
                // SizedBox(height: size.getWidthPx(28)),
                // Text(
                //   "Or Login with",
                //   style: TextStyle(
                //       fontFamily: 'Exo2', fontSize: 16.0, color: Colors.grey),
                // ),
                // SizedBox(height: size.getWidthPx(12)),
                // _socialButtons()
              ],
            )),
      );
}
