import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ujikom/auth.dart';
import 'package:ujikom/main.dart';

class RegisterPage extends StatefulWidget {
  final Function? toggleView;
  RegisterPage({this.toggleView});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = new AuthService();
  bool _obscureText = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _telepon = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('ujikom');
    final emailField = TextFormField(
        controller: _email,
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
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))));

    final passwordField = TextFormField(
        obscureText: _obscureText,
        controller: _password,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required !!';
          }
          if (value.trim().length < 8) {
            return 'Password must be at least 8 characters in length';
          }
          // Return null if the entered password is valid
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))));

    final namefield = TextFormField(
        controller: _name,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required !!';
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nama Lengkap",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))));

    final teleponfield = TextFormField(
        controller: _telepon,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required !!';
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "No Telepon",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))));

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var collection = FirebaseFirestore.instance.collection('ujikom');
            var res = await collection.add({
              'email': _email.text,
              'password': _password.text,
              'username': _name.text,
              'nomor_telepon': _telepon.text
            });
            print(res);
            _ayoRegister(_email.text, _password.text);
            dynamic result = await _auth.registerEmailPassword(
                LoginUser(email: _email.text, password: _password.text));
            Navigator.pop(context);
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
        child: Text(
          "Register",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text('Registration Page'),
          backgroundColor: Colors.redAccent.shade700),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Text(
                    'Register',
                    style: TextStyle(color: Colors.black, fontSize: 50),
                  ),
                  SizedBox(height: 10.0),
                  const SizedBox(height: 30.0),
                  emailField,
                  const SizedBox(height: 20.0),
                  passwordField,
                  const SizedBox(height: 20.0),
                  namefield,
                  const SizedBox(height: 20.0),
                  teleponfield,
                  const SizedBox(height: 20.0),
                  registerButton,
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _ayoRegister(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .whenComplete(() => {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ))
                });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for the email');
        }
      } catch (e) {
        print(e);
      }
    }
    CircularProgressIndicator();
  }
}
