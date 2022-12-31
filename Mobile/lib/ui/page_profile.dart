import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/utils.dart';
import '../widgets/utils_widget.dart';
import '../widgets/widgets.dart';
import 'page_edit_profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  String nama_lengkap = "";
  String username = "";
  String id_pengguna= "";
  String telepon = "";
  String alamat1 = "";
  String alamat2 = "";
  String alamat3 = "";
  String pass = "";

  Future getNama() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username') ?? "");
      id_pengguna = (prefs.getString('id_pengguna') ?? "");
      nama_lengkap = (prefs.getString('nama_lengkap') ?? "");
      telepon = (prefs.getString('telepon') ?? "");
      alamat1 = (prefs.getString('alamat1') ?? "");
      alamat2 = (prefs.getString('alamat2') ?? "");
      alamat3 = (prefs.getString('alamat3') ?? "");
      pass = (prefs.getString('password') ?? "");
    });
  }

  @override
  void initState() {
    super.initState();
    getNama();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: ClipPath(
                clipper: UpperClipper(),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [colorCurve, colorCurve],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 60),
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: CircleAvatar(
                      foregroundColor: backgroundColor,
                      maxRadius: 50,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        maxRadius: 48,
                        foregroundColor: colorCurve,
                        backgroundImage: NetworkImage(
                            'https://avatars3.githubusercontent.com/u/17440971?s=400&u=b0d8df93a2e45812e577358cd66849e9d7cf0f90&v=4'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    nama_lengkap,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    username,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 20, left: 50, right: 50, bottom: 20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "User Information",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          leading: Icon(Icons.phone),
                                          title: Text("Telepon"),
                                          subtitle: Text(telepon),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.my_location),
                                          title: Text("Alamat 1"),
                                          subtitle: Text(alamat1),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.my_location),
                                          title: Text("Alamat 2"),
                                          subtitle: Text(alamat2),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.my_location),
                                          title: Text("Alamat 3"),
                                          subtitle: Text(alamat3),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20.0),
                        ),
                        ElevatedButton(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: colorCurve,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(50.0))),
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Edit',
                              style: TextStyle(
                                  fontFamily: 'Exo2',
                                  color: Colors.white,
                                  fontSize: 12.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfilePage()));
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
