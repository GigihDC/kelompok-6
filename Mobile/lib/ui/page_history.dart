import 'package:flutter/material.dart';
import 'package:rushbin/ui/page_subHistory.dart';
import '../utils/utils.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Screen size;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Histori",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            TabBar(
                isScrollable: true,
                indicatorColor: Colors.grey.shade800,
                indicator: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueGrey.shade200),
                tabs: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Tab(
                      icon: Icon(
                        Icons.pending_actions_rounded,
                        color: Colors.black,
                      ),
                      child: Text(
                        "Pengantaran",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Tab(
                      icon: Icon(
                        Icons.pending_actions_rounded,
                        color: Colors.black,
                      ),
                      child: Text(
                        "Penukaran",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Tab(
                      icon: Icon(
                        Icons.pending_actions_rounded,
                        color: Colors.black,
                      ),
                      child: Text(
                        "Pendapatan",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ]),
            Expanded(
              child: TabBarView(
                children: [
                  SubHistoryPage(),
                  Penukaran(),
                  pendapatan(),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  // Container _ButtonWidget() {
  //   return Container(
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //           primary: colorCurve,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: 
  //                       new BorderRadius.horizontal(left: Radius.circular(30.0)))),
  //       child: Text(
  //         "Penukaran",
  //         style: TextStyle(
  //             fontFamily: 'Exo2', color: Colors.white, fontSize: 14.0),
  //       ),
  //       onPressed: () {},
  //     ),
  //     ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //           primary: colorCurve,),
  //       child: Text(
  //         "Pemasukan",
  //         style: TextStyle(
  //             fontFamily: 'Exo2', color: Colors.white, fontSize: 14.0),
  //       ),
  //       onPressed: () {},
  //     ),
  //     ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //           primary: colorCurve,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: 
  //                       new BorderRadius.horizontal(right: Radius.circular(30.0)))),
  //       child: Text(
  //         "Pengantaran",
  //         style: TextStyle(
  //             fontFamily: 'Exo2', color: Colors.white, fontSize: 14.0),
  //       ),
  //       onPressed: () {},
  //     ),
  //       ],
  //     ),
  //   );
  // }

  // Container _bodyRiwayat() {
  //   return Container(
  //     child: Column(
  //       children:[

  //       ]
  //     ),
  //   );
  // }

}
