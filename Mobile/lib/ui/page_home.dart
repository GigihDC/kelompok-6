import 'package:flutter/material.dart';
import 'page_profile.dart';
import '../widgets/bottom_navigationBar.dart';
import '../main.dart';
import 'page_history.dart';
import 'page_pickup.dart';
import 'page_login.dart';
import 'page_profile.dart';
import 'page_dashboard.dart';
import 'page_settings.dart';
import 'page_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String username = "";
  String id_pengguna = "";
  String nama_lengkap = "";
  String telepon = "";
  String alamat1 = "";
  String alamat2 = "";
  String alamat3 = "";
  String point = "";
  String pass = "";

  int _selectedIndex = 0;

  Future getkode() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = (prefs.getString('username') ?? "");
      id_pengguna = (prefs.getString('id_pengguna') ?? "");
      nama_lengkap = (prefs.getString('nama_lengkap') ?? "");
      telepon = (prefs.getString('telepon') ?? "");
      alamat1 = (prefs.getString('alamat1') ?? "");
      alamat2 = (prefs.getString('alamat2') ?? "");
      alamat3 = (prefs.getString('alamat3') ?? "");
      point = (prefs.getString('point') ?? "");
      pass = (prefs.getString('password') ?? "");
    });
  }

  int currentTab = 0;
  PageController pageController;

  _changeCurrentTab(int tab) {
    //Changing tabs from BottomNavigationBar
    setState(() {
      currentTab = tab;
      pageController.jumpToPage(0);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = new PageController();
    getkode();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: bodyView(currentTab),
          bottomNavigationBar:
              BottomNavBar(changeCurrentTab: _changeCurrentTab)),
    );
  }

  bodyView(currentTab) {
    List<Widget> tabView = [];
    //Current Tabs in Home Screen...
    switch (currentTab) {
      case 0:
        //Dashboard Page
        tabView = [DashboardPage()];
        break;
      case 1:
        //History Page
        tabView = [HistoryPage()];
        break;
      case 2:
        //Pickup Page
        tabView = [PickupPage()];
        break;
      case 3:
        //Profile Page
        tabView = [ProfilePage()];
        break;
      case 4:
        //Setting Page
        tabView = [SettingPage()];
        break;
    }
    return PageView(controller: pageController, children: tabView);
  }
}
