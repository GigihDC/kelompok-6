import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'page_profile.dart';
import 'package:rushbin/api.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key key}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _isObscure = false;
  String nama_lengkapS = "";
  String usernameS = "";
  String id_penggunaS = "";
  String teleponS = "";
  String alamat1S = "";
  String alamat2S = "";
  String alamat3S = "";
  String passS = "";

  Future getDataProfile() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      id_penggunaS = (prefs.getString('id_pengguna') ?? "");
      usernameS = (prefs.getString('username') ?? "");
      passS = (prefs.getString('password') ?? "");
      teleponS = (prefs.getString('telepon') ?? "");
      alamat1S = (prefs.getString('alamat1') ?? "");
      alamat2S = (prefs.getString('alamat2') ?? "");
      alamat3S = (prefs.getString('alamat3') ?? "");
      nama_lengkapS = (prefs.getString('nama_lengkap') ?? "");
    });
  }

  @override
  void initState() {
    super.initState();
    getDataProfile();
  }
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Screen size;

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController(text: nama_lengkapS);
    final _emailController = TextEditingController(text: usernameS);
    final _teleponController = TextEditingController(text: teleponS);
    final _alamat1Controller = TextEditingController(text: alamat1S);
    final _alamat2Controller = TextEditingController(text: alamat2S);
    final _alamat3Controller = TextEditingController(text: alamat3S);
    final _passController = TextEditingController(text: passS);
    final _idController = TextEditingController(text: id_penggunaS);
    FocusNode _nameFocusNode = FocusNode();
    FocusNode _emailFocusNode = FocusNode();
    FocusNode _teleponFocusNode = FocusNode();
    FocusNode _alamat1FocusNode = FocusNode();
    FocusNode _alamat2FocusNode = FocusNode();
    FocusNode _alamat3FocusNode = FocusNode();
    FocusNode _passFocusNode = FocusNode();
    FocusNode _idFocusNode = FocusNode();
    
    Future<void> editProfile() async {
      var url = Uri.parse("${fire.URL_API}/profil.php");
      var response = await http.post(url, body: {
        "id_user": _idController.text.toString(),
        "username": _emailController.text.toString(),
        "nama_lengkap": _nameController.text.toString(),
        "password": _passController.text.toString(),
        "telepon": _teleponController.text.toString(),
        "alamat1": _alamat1Controller.text.toString(),
        "alamat2": _alamat2Controller.text.toString(),
        "alamat3": _alamat3Controller.text.toString()
      });
      var dataAwal = jsonEncode(response.body);
      var dataJadi = jsonDecode(dataAwal);
      // print(dataJadi);
      if (dataJadi == "gagal") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Edit Gagal")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Edit Berhasil")),
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('nama_lengkap', _nameController.text.toString());
        await prefs.setString('password', _passController.text.toString());
        await prefs.setString('telepon', _teleponController.text.toString());
        await prefs.setString('alamat1', _alamat1Controller.text.toString());
        await prefs.setString('alamat2', _alamat2Controller.text.toString());
        await prefs.setString('alamat3', _alamat3Controller.text.toString());
        
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilePage()));
      }
    }

    TextFormField _passWidget() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Data tidak boleh kosong";
          } else {
            return null;
          }
        },
        controller: _passController,
        focusNode: _passFocusNode,
        style: TextStyle(height: 1.5),
        decoration: InputDecoration(
            hintText: passS,
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
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_teleponFocusNode);
        }
        );
  }

  TextFormField _emailWidget() {
    return TextFormField(
      readOnly: true,
        controller: _emailController,
        focusNode: _emailFocusNode,
        style: TextStyle(height: 1.5),
        decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 24, fontFamily: 'Exo2', color: textPrimaryColor),
            labelText: 'Email',
            prefixIcon: Icon(Icons.email, color: colorCurve),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: colorCurve))),
        obscureText: false,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_passFocusNode);
        });
  }

  TextFormField _nameWidget() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Data tidak boleh kosong";
          } else {
            return null;
          }
        },
        controller: _nameController,
        focusNode: _nameFocusNode,
        style: TextStyle(height: 1.5),
        decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 24, fontFamily: 'Exo2', color: textPrimaryColor),
            labelText: 'Nama',
            hintText: nama_lengkapS,
            prefixIcon: Icon(Icons.person, color: colorCurve),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: colorCurve))),
        obscureText: false,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_alamat1FocusNode);
        });
  }

  TextFormField _teleponWidget() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Data tidak boleh kosong";
          } else {
            return null;
          }
        },
        controller: _teleponController,
        focusNode: _teleponFocusNode,
        style: TextStyle(height: 1.5),
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 24, fontFamily: 'Exo2', color: textPrimaryColor),
            labelText: 'Telepon',
            hintText: teleponS,
            prefixIcon: Icon(Icons.phone, color: colorCurve),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: colorCurve))),
        obscureText: false,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_nameFocusNode);
        });
  }

  TextFormField _idWidget() {
    return TextFormField(
      readOnly: true,
      controller: _idController,
      focusNode: _idFocusNode,
      style: TextStyle(height: 1.5),
      decoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 24, fontFamily: 'Exo2', color: textPrimaryColor),
          labelText: 'ID User',
          prefixIcon: Icon(Icons.person_add_disabled, color: colorCurve),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: colorCurve))),
      obscureText: false,
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(_emailFocusNode);
      });
  }

  TextFormField _alamat1Widget() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Data tidak boleh kosong";
          } else {
            return null;
          }
        },
        controller: _alamat1Controller,
        focusNode: _alamat1FocusNode,
        style: TextStyle(height: 1.5),
        decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 24, fontFamily: 'Exo2', color: textPrimaryColor),
            labelText: 'Alamat',
            hintText: alamat1S,
            prefixIcon: Icon(Icons.my_location, color: colorCurve),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: colorCurve))),
        obscureText: false,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_alamat2FocusNode);
        });
  }

  TextFormField _alamat2Widget() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Data tidak boleh kosong";
          } else {
            return null;
          }
        },
        controller: _alamat2Controller,
        focusNode: _alamat2FocusNode,
        style: TextStyle(height: 1.5),
        decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 24, fontFamily: 'Exo2', color: textPrimaryColor),
            labelText: 'Alamat',
            hintText: alamat2S,
            prefixIcon: Icon(Icons.my_location, color: colorCurve),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: colorCurve))),
        obscureText: false,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_alamat3FocusNode);
        });
  }

  TextFormField _alamat3Widget() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Data tidak boleh kosong";
          } else {
            return null;
          }
        },
        controller: _alamat3Controller,
        focusNode: _alamat3FocusNode,
        style: TextStyle(height: 1.5),
        decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 24, fontFamily: 'Exo2', color: textPrimaryColor),
            labelText: 'Alamat',
            hintText: alamat3S,
            prefixIcon: Icon(Icons.my_location, color: colorCurve),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: colorCurve))),
        obscureText: false,);
  }

  Container _saveButtonWidget() {
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
          "Save",
          style: TextStyle(
              fontFamily: 'Exo2', color: Colors.white, fontSize: 20.0),
        ),
        // color: colorCurve,
        onPressed: () async {
          editProfile();
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => ProfilePage()));
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
                _idWidget(),
                SizedBox(height: size.getWidthPx(10)),
                _emailWidget(),
                SizedBox(height: size.getWidthPx(10)),
                _passWidget(),
                SizedBox(height: size.getWidthPx(10)),
                _teleponWidget(),
                SizedBox(height: size.getWidthPx(10)),
                _nameWidget(),
                SizedBox(height: size.getWidthPx(10)),
                _alamat1Widget(),
                SizedBox(height: size.getWidthPx(10)),
                _alamat2Widget(),
                SizedBox(height: size.getWidthPx(10)),
                _alamat3Widget(),
                SizedBox(height: size.getWidthPx(10)),
                _saveButtonWidget(),
              ],
            )),
      );

    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: <Widget>[
        ClipPath(
            clipper: UpperClipper(),
            child: Container(
                height: size.getWidthPx(200),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [colorCurve, colorCurveSecondary],
                )))),
        SingleChildScrollView(
            child: SafeArea(
          top: true,
          bottom: false,
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: size.getWidthPx(20), vertical: size.getWidthPx(10)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    // padding: EdgeInsets.only(top: 60),
                    child: Column(children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          SizedBox(width: size.getWidthPx(10)),
                          Text("Edit Profile", style: TextStyle(fontFamily: "Exo2", fontSize: 24, color: Colors.white),),
                        ],
                      ),
                      SizedBox(height: size.getWidthPx(36),),
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
                        padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                        child: Icon(
                          Icons.add_circle,
                          color: Colors.grey.shade700,
                          size: 25.0,
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: size.getWidthPx(10)),
                  // SizedBox(height: size.getWidthPx(10)),
                  // _textAccount(),
                  // SizedBox(height: size.getWidthPx(30)),
                  registerFields()
                ]),
          ),
        ))
      ]),
    );
  }

  
}
