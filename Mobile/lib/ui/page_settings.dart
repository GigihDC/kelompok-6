import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page_login.dart';
import 'page_terms&conditions.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isLocalNotification = false;
  // bool isPushNotification = true;
  // bool isPrivateAccount = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("More",
            style:
                TextStyle(fontFamily: "Exo2", color: textSecondaryLightColor)),
        backgroundColor: Colors.white,
      ),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: backgroundColor,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: backgroundColor),
        child: Container(
          color: backgroundColor,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                // accountSection(),
                // pushNotificationSection(),
                SizedBox(height: 10),
                getHelpSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SettingSection getHelpSection() {
    return SettingSection(
      headerText: "Get Help".toUpperCase(),
      headerFontSize: 18.0,
      headerTextColor: Colors.black87,
      backgroundColor: Colors.white,
      disableDivider: false,
      children: <Widget>[
        Container(
          child: TileRow(
            label: "Contact Us",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
              label: "Terms and Conditions",
              disableDivider: false,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsConditionPage()));
              }),
        ),
        Container(
          child: TileRow(
            label: "Log out",
            disableDivider: false,
            onTap: () {
              _showAlertDialog();
            },
          ),
        )
      ],
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLoggedIn', false);
                await prefs.setString(
                  'username',
                  "",
                );
                await prefs.setString(
                  'id_pengguna',
                  "",
                );
                await prefs.setString(
                  'nama_lengkap',
                  "",
                );
                await prefs.setString(
                  'telepon',
                  "",
                );
                await prefs.setString(
                  'alamat1',
                  "",
                );
                await prefs.setString(
                  'alamat2',
                  "",
                );
                await prefs.setString(
                  'alamat3',
                  "",
                );
                await prefs.setString(
                  'point',
                  "",
                );
                await prefs.setString(
                  'password',
                  "",
                );
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        );
      },
    );
  }

  // SettingSection accountSection() {
  //   return SettingSection(
  //     headerText: "Account".toUpperCase(),
  //     headerFontSize: 15.0,
  //     headerTextColor: Colors.black87,
  //     backgroundColor: Colors.white,
  //     disableDivider: false,
  //     children: <Widget>[
  //       Container(
  //         child: TileRow(
  //           label: "User Name",
  //           disabled: true,
  //           rowValue: "harsh719",
  //           disableDivider: false,
  //           onTap: () {},
  //         ),
  //       ),
  //       Container(
  //         child: SwitchRow(
  //           label: "Private Account",
  //           disableDivider: false,
  //           value: isPrivateAccount,
  //           onSwitchChange: (switchStatus) {
  //             setState(() {
  //               switchStatus
  //                   ? isPrivateAccount = true
  //                   : isPrivateAccount = false;
  //             });
  //           },
  //           onTap: () {},
  //         ),
  //       ),
  //       Container(
  //         child: TileRow(
  //           label: "Change Password",
  //           disableDivider: false,
  //           onTap: () {},
  //         ),
  //       )
  //     ],
  //   );
  // }

//   SettingSection pushNotificationSection() {
//     return SettingSection(
//       headerText: "Push Notifications".toUpperCase(),
//       headerFontSize: 15.0,
//       headerTextColor: Colors.black87,
//       backgroundColor: Colors.white,
//       disableDivider: false,
//       children: <Widget>[
//         Container(
//           child: SwitchRow(
//             label: "Push Notification",
//             disableDivider: false,
//             value: isPushNotification,
//             onSwitchChange: (switchStatus) {
//               setState(() {
//                 switchStatus
//                     ? isPushNotification = true
//                     : isPushNotification = false;
//               });
//             },
//             onTap: () {},
//           ),
//         ),
//         Container(
//           child: SwitchRow(
//             label: "Local Notification",
//             disableDivider: false,
//             value: isLocalNotification,
//             onSwitchChange: (switchStatus) {
//               setState(() {
//                 switchStatus
//                     ? isLocalNotification = true
//                     : isLocalNotification = false;
//               });
//             },
//             onTap: () {},
//           ),
//         )
//       ],
//     );
//   }
}
