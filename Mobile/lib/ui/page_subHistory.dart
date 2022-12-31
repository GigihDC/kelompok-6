import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rushbin/api.dart';
import 'page_historydata.dart';
import 'page_historytransaction.dart';
import 'page_historychange.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class SubHistoryPage extends StatefulWidget {
  const SubHistoryPage({Key key}) : super(key: key);

  @override
  State<SubHistoryPage> createState() => _SubHistoryPageState();
}

class _SubHistoryPageState extends State<SubHistoryPage> {
  // late List Informasi;
  // String idPengguna = "";

  // Future<String> getInformasi() async {
  //   Uri url = Uri.parse(
  //       "${fire.URL_API}/histori.php");
  //   var response = await http.post(url, body: {"id_Pengguna": idPengguna.toString()});
  //   setState(() {
  //     Informasi = json.decode(response.body);
  //   });
  //   return "Success!";
  // }

  // void initState() {
  //   getInformasi();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }



  List<DataRiwayat> lisPending;
  String idPengguna = "";

  Future getIdUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      idPengguna = (prefs.getString('id_pengguna') ?? "");
      // print(idUser);
    });
  }

  Future<void> getDataRiwayat() async {
    Uri url = Uri.parse(
        "${fire.URL_API}/pickuphistori.php");
    var response = await http.post(url, body: {"id_Pengguna": idPengguna.toString()});
    setState(() {
      lisPending = jsonDecode(response.body)
          .map((item) => DataRiwayat.fromJson(item))
          .toList()
          .cast<DataRiwayat>();
    });
  }

  @override
  void initState() {
    super.initState();
    getDataRiwayat();
    getIdUser();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(



  //     body: Padding(
  //               padding: EdgeInsets.only(left: 5, top: 20),
  //               child: FutureBuilder(
  //                   future: getInformasi(),
  //                   builder: (context, AsyncSnapshot snapshot) {
  //                     if (snapshot.hasData) {
  //                       return ListView.separated(
  //                         itemCount: Informasi == null ? 0 : Informasi.length,
  //                         itemBuilder: (BuildContext context, int index) {
  //                           return ExpansionTile(
  //                             title: Text(
  //                               Informasi[index]["pertanyaan"],
  //                               style: GoogleFonts.montserrat(
  //                                   color: Colors.black,
  //                                   fontSize: 15,
  //                                   fontWeight: FontWeight.w500),
  //                             ),
  //                             children: <Widget>[
  //                               ListTile(
  //                                 title: Text(
  //                                   Informasi[index]["jawaban"],
  //                                   style: GoogleFonts.montserrat(
  //                                       color: Colors.black,
  //                                       fontSize: 15,
  //                                       fontWeight: FontWeight.w600),
  //                                 ),
  //                               )
  //                             ],
  //                           );
  //                         },
  //                         separatorBuilder: (BuildContext context, int index) =>
  //                             const Divider(),
  //                       );
  //                     } else {
  //                       return Center(
  //                         child: Container(),
  //                       );
  //                     }
  //                   }))



      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.greenAccent,
              child: IconButton(
                splashRadius: 35,
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  getDataRiwayat();
                },
              ),
            ),
          ),
          SizedBox(height: 25),
          if (lisPending != null)
            Expanded(
              child: ListView.builder(
                  itemCount: lisPending.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 20),
                          child: Container(
                            width: double.infinity,
                            height: 85,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              border: Border.all(
                                  color: Colors.grey.shade700,
                                  width: 1,
                                  style: BorderStyle.solid),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey,
                                  spreadRadius: 0.8,
                                  blurRadius: 9,
                                  offset: const Offset(5.0, 5.0),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Text("${lisPending[index].tanggal.toString()}",
                                  // style: GoogleFonts.openSans(
                                  //       textStyle: TextStyle(
                                  //           color: Colors.black,
                                  //           fontWeight: FontWeight.bold,
                                  //           fontSize: 12)),
                                  // ),
                                  CircleAvatar(
                                    radius: 17,
                                    child: Icon(Icons.car_rental,
                                        color: Colors.black),
                                    backgroundColor: Colors.white,
                                  ),
                                ],
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    "ID Transaksi: ",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ),
                                  Text(
                                    "${lisPending[index].idPengantaran}",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    "Tanggal : ",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ),
                                  Text(
                                    "${lisPending[index].tanggal}",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 17,
                                    child: Icon(Icons.check,
                                        color: lisPending[index].status ==
                                                    "1"
                                                ? Colors.red
                                                : Colors.green,),
                                    backgroundColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
        ],
      ),





    );
  }
}


class Penukaran extends StatefulWidget {
  const Penukaran({Key key}) : super(key: key);

  @override
  State<Penukaran> createState() => _penukaranState();
}

class _penukaranState extends State<Penukaran> {
  List<ChangeHistori> lisPending;
  String idPengguna = "";

  Future getIdUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      idPengguna = (prefs.getString('id_pengguna') ?? "");
      // print(idUser);
    });
  }

  Future<void> getDataRiwayat() async {
    Uri url = Uri.parse(
        "${fire.URL_API}/penukaranhistori.php");
    var response = await http.post(url, body: {"id_Pengguna": idPengguna.toString()});
    setState(() {
      lisPending = jsonDecode(response.body)
          .map((item) => ChangeHistori.fromJson(item))
          .toList()
          .cast<ChangeHistori>();
    });
  }

  @override
  void initState() {
    super.initState();
    getDataRiwayat();
    getIdUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.greenAccent,
              child: IconButton(
                splashRadius: 35,
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  getDataRiwayat();
                },
              ),
            ),
          ),
          SizedBox(height: 25),
          if (lisPending != null)
            Expanded(
              child: ListView.builder(
                  itemCount: lisPending.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 20),
                          child: Container(
                            width: double.infinity,
                            height: 85,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              border: Border.all(
                                  color: Colors.grey.shade700,
                                  width: 1,
                                  style: BorderStyle.solid),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey,
                                  spreadRadius: 0.8,
                                  blurRadius: 9,
                                  offset: const Offset(5.0, 5.0),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 17,
                                    child: Icon(Icons.handshake,
                                        color: Colors.black),
                                    backgroundColor: Colors.white,
                                  ),
                                ],
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    "ID Transaksi: ",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ),
                                  Text(
                                    "${lisPending[index].idPenukaran}",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    "Tanggal : ",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ),
                                  Text(
                                    "${lisPending[index].tanggal}",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Rp. ${lisPending[index].nominal}",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ),
                                  Text(
                                    "${lisPending[index].point}",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: lisPending[index].point ==
                                                    "1000"
                                                ? Colors.red
                                                : Colors.blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
        ],
      ),
    );
  }
}


class pendapatan extends StatefulWidget {
  const pendapatan({Key key}) : super(key: key);

  @override
  State<pendapatan> createState() => _pendapatanState();
}

class _pendapatanState extends State<pendapatan> {
  List<PendapatanRiwayat> lisPending;
  String idPengguna = "";

  Future getIdUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      idPengguna = (prefs.getString('id_pengguna') ?? "");
      // print(idUser);
    });
  }

  Future<void> getDataRiwayat() async {
    Uri url = Uri.parse(
        "${fire.URL_API}/pemasukanhistori.php");
    var response = await http.post(url, body: {"id_Pengguna": idPengguna.toString()});
    setState(() {
      lisPending = jsonDecode(response.body)
          .map((item) => PendapatanRiwayat.fromJson(item))
          .toList()
          .cast<PendapatanRiwayat>();
    });
  }

  @override
  void initState() {
    super.initState();
    getDataRiwayat();
    getIdUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.greenAccent,
              child: IconButton(
                splashRadius: 35,
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  getDataRiwayat();
                },
              ),
            ),
          ),
          SizedBox(height: 25),
          if (lisPending != null)
            Expanded(
              child: ListView.builder(
                  itemCount: lisPending.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 20),
                          child: Container(
                            width: double.infinity,
                            height: 85,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              border: Border.all(
                                  color: Colors.grey.shade700,
                                  width: 1,
                                  style: BorderStyle.solid),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey,
                                  spreadRadius: 0.8,
                                  blurRadius: 9,
                                  offset: const Offset(5.0, 5.0),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 17,
                                    child: Icon(Icons.money,
                                        color: Colors.black),
                                    backgroundColor: Colors.white,
                                  ),
                                ],
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    "ID Transaksi: ",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ),
                                  Text(
                                    "${lisPending[index].kodeTransaksi}",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    "Tanggal : ",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ),
                                  Text(
                                    "${lisPending[index].tanggal}",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${lisPending[index].totalPoint}",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
        ],
      ),
    );
  }
}