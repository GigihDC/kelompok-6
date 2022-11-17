import 'dart:convert';
import 'dart:html';
import 'package:rushbin/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rushbin/register.dart';
import 'package:rushbin/auth.dart';
import 'package:rushbin/home.dart';
import 'package:rushbin/drawer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rushbin/header.dart';

class LoginPage extends StatefulWidget {
  final Function? toggleView;
  LoginPage({this.toggleView});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        controller: emailController,
        autofocus: false,
        validator: (value) {
          if (value != null) {
            if (value.contains('@') && value.endsWith('.com')) {
              return null;
            }
            return 'Enter a Valid Email Address';
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            hintText: "Masukkan Email Anda",
            labelText: "Email",
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            )));

    final passwordField = TextFormField(
        obscureText: _obscureText,
        controller: passController,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (value.trim().length < 8) {
            return 'Password must be at least 8 characters in length';
          }
          // Return null if the entered password is valid
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Masukkan Password Anda",
            labelText: "Password",
            prefixIcon: Icon(Icons.password),
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            )));

    final txtbutton = TextButton(
        onPressed: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (context) => RegisterPage());
          Navigator.push(context, route);
        },
        child: const Text('New? Register here'));

    final loginEmailPasswordButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: ElevatedButton(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
            child: Text(
              "SIGN IN",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            dynamic result = await _auth.signInEmailPassword(LoginUser(
                email: emailController.text, password: passController.text));
            Route route = MaterialPageRoute(builder: (context) => Home());
            Navigator.push(context, route);
            if (result.uid == null) {
              //null means unsuccessfull authentication
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(result.code),
                    );
                  });
            }
          }
        },
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            height: 250,
            child: HeaderWidget(
                250, true, Icons.login), //let's create a common header widget
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  // Text(
                  //   'Login',
                  //   style: TextStyle(color: Colors.black, fontSize: 50),
                  // ),
                  SizedBox(height: 20.0),
                  emailField,
                  const SizedBox(height: 15.0),
                  passwordField,
                  const SizedBox(height: 15.0),
                  txtbutton,
                  const SizedBox(height: 25.0),
                  loginEmailPasswordButon,
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
