import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'package:rushbin/api.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PickupPage extends StatefulWidget {
  @override
  _PickupPageState createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  String idPengguna = "";
  String alamat1 = "";
  String alamat2 = "";
  String alamat3 = "";

  Future getUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      idPengguna = (prefs.getString('id_pengguna') ?? "");
      alamat1 = (prefs.getString('alamat1') ?? "");
      alamat2 = (prefs.getString('alamat2') ?? "");
      alamat3 = (prefs.getString('alamat3') ?? "");
    });
  }
  TextEditingController _addreesController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  FocusNode _addressFocusNode = new FocusNode();
  FocusNode _descFocusNode = new FocusNode();
  Screen size;

  Future<void> _uploadAwal() async {
    Uri url = Uri.parse(
        "${fire.URL_API}/upload.php");
    var response = await http.post(url, body: {
      "tanggal": DateTime.now().toString(),
      "status": "1",
      "id_user": idPengguna.toString(),
      "gambar1": "$namaBukti",
      "gambar2": "$namaBukti2",
      "gambar3": "$namaBukti3",
      "deskripsi": _descController.text.toString(),
      "alamat": _addreesController.text.toString()
    });
    var data = jsonDecode(response.body);
    if (data == "gagal") {
      Fluttertoast.showToast(
          msg: "gagal! cek kembali",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } else {
      Fluttertoast.showToast(
          msg: "berhasil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white);
    }
  }

  final picker = ImagePicker();
  var urlBukti;
  var namaBukti;
  Future pilihBukti() async {
    var result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      print(result.name);
      print(result.path);
      setState(() {
        urlBukti = result.path;
        namaBukti = result.name;
      });
    } else {}
  }

  Future saveBukti() async {
    final uri = Uri.parse(
        "${fire.URL_API}/pictureLink.php");
    var request = http.MultipartRequest('POST', uri);
    var uploadBukti = await http.MultipartFile.fromPath('image', urlBukti);
    request.files.add(uploadBukti);
    var response = await request.send();
    if (response.statusCode == 200) {
      print(response.reasonPhrase);
    }
  }

  var urlBukti2;
  var namaBukti2;
  Future pilihBukti2() async {
    var result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      print(result.name);
      print(result.path);
      setState(() {
        urlBukti2 = result.path;
        namaBukti2 = result.name;
      });
    } else {}
  }

  Future saveBukti2() async {
    final uri = Uri.parse(
        "${fire.URL_API}/pictureLink.php");
    var request = http.MultipartRequest('POST', uri);
    var uploadBukti2 = await http.MultipartFile.fromPath('image', urlBukti2);
    request.files.add(uploadBukti2);
    var response = await request.send();
    if (response.statusCode == 200) {
      print(response.reasonPhrase);
    }
  }
  
  var urlBukti3;
  var namaBukti3;
  Future pilihBukti3() async {
    var result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      print(result.name);
      print(result.path);
      setState(() {
        urlBukti3 = result.path;
        namaBukti3 = result.name;
      });
    } else {}
  }

  Future saveBukti3() async {
    final uri = Uri.parse(
        "${fire.URL_API}/pictureLink.php");
    var request = http.MultipartRequest('POST', uri);
    var uploadBukti3 = await http.MultipartFile.fromPath('image', urlBukti3);
    request.files.add(uploadBukti3);
    var response = await request.send();
    if (response.statusCode == 200) {
      print(response.reasonPhrase);
    }
  }


  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  List<String> alamat_user = [
    alamat1,
    alamat2,
    alamat3,
  ];
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
                          children: <Widget>[
                            upperPart(),
                            SizedBox(height: 5,),
                            ElevatedButton(onPressed: () {
                              _uploadAwal();
                            }, child: Text("ok"),),
                            // CircleAvatar(child: Image.file(urlBukti))
                          ],
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
                  onPressed: () async {
                    pilihBukti();
                    saveBukti();
                  },
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
                  onPressed: () async {
                    pilihBukti2();
                    saveBukti2();
                  },
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
                  onPressed: () {
                    pilihBukti3();
                    saveBukti3();
                  },
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
