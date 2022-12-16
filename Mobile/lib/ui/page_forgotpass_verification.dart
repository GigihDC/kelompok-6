import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import '../widgets/widgets.dart';
import '../utils/utils.dart';
import '../utils/theme_helper.dart';
import 'page_login.dart';

class PageForgotPasswordVerification extends StatefulWidget {
  @override
  _PageForgotPasswordVerificationState createState() =>
      _PageForgotPasswordVerificationState();
}

class _PageForgotPasswordVerificationState
    extends State<PageForgotPasswordVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  bool isLoading = false;
  bool _pinSuccess = false;

  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Container(
      color: backgroundColor,
      child: SafeArea(
        bottom: false,
        top: true,
        child: Scaffold(
            appBar: AppBar(
                elevation: 0.0,
                primary: false,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: colorCurve,
                  ),
                  onPressed: () => Navigator.pop(context, false),
                )),
            backgroundColor: backgroundColor,
            resizeToAvoidBottomInset: false,
            body: Stack(children: <Widget>[
              ClipPath(
                  clipper: BottomShapeClipper(),
                  child: Container(
                    color: colorCurve,
                  )),
              Center(
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _verificationGradientText(),
                        Header(),
                        // child: _emailFeild()
                        _otpField(),
                        Resend(),
                        Container(
                          decoration: _pinSuccess
                              ? ThemeHelper().buttonBoxDecoration(context)
                              : ThemeHelper().buttonBoxDecoration(
                                  context, "#AAAAAA", "#757575"),
                        ),
                        verifyButton()
                      ],
                    ),
                  ),
                ),
              )
            ])),
      ),
    );
  }

  Header() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // _passwordIconWidget(),
          SizedBox(height: size.getWidthPx(16)),
          Text(
            "Enter the verification code we just sent you on your email address.",
            style: TextStyle(
                fontFamily: 'Exo2',
                fontSize: 16.0,
                fontStyle: FontStyle.normal),
          ),
        ],
      );

  GradientText _verificationGradientText() {
    return GradientText('Verification',
        gradient: LinearGradient(colors: [
          Color.fromRGBO(97, 6, 165, 1.0),
          Color.fromRGBO(45, 160, 240, 1.0)
        ]),
        style: TextStyle(
            fontFamily: 'Exo2', fontSize: 30, fontWeight: FontWeight.bold));
  }

  // CircleAvatar _passwordIconWidget() {
  //   return CircleAvatar(
  //     maxRadius: size.getWidthPx(82),
  //     child: Image.asset("icons/imgforgot.png"),
  //     backgroundColor: colorCurve,
  //   );
  // }

  OTPTextField _otpField() {
    return OTPTextField(
      length: 4,
      width: 300,
      fieldWidth: 50,
      style: TextStyle(fontSize: 30),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        setState(() {
          _pinSuccess = true;
        });
      },
    );
  }

  Resend() => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: size.getWidthPx(24)),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "If you didn't receive a code! ",
                    style: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                  TextSpan(
                    text: 'Resend',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ThemeHelper().alartDialog(
                                "Successful",
                                "Verification code resend successful.",
                                context);
                          },
                        );
                      },
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
            )
          ]);

  ElevatedButton verifyButton() {
    return ElevatedButton(
        style: ThemeHelper().buttonStyle(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Text(
            "Verify".toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        onPressed: _pinSuccess
            ? () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false);
              }
            : null);
  }

//   BoxField _emailWidget() {
//     return BoxField(
//       hintText: "Enter email",
//       lableText: "Email",
//       obscureText: false,
//       onSaved: (String val) {},
//       validator: validateEmail,
//       icon: Icons.email,
//       iconColor: colorCurve,
//     );
//   }

//   _emailFeild() => Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           _emailWidget(),
//           SizedBox(height: size.getWidthPx(20)),
//           _submitButtonWidget(),
//         ],
//       );

//   Container _submitButtonWidget() {
//     return Container(
//       padding: EdgeInsets.symmetric(
//           vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)),
//       width: size.getWidthPx(200),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//             backgroundColor: colorCurve,
//             foregroundColor: colorCurveSecondary,
//             shape: RoundedRectangleBorder(
//                 borderRadius: new BorderRadius.circular(30.0))),
//         // elevation: 8.0,
//         // padding: EdgeInsets.all(size.getWidthPx(12)),
//         child: Text(
//           "Submit",
//           style: TextStyle(
//               fontFamily: 'Exo2', color: Colors.white, fontSize: 20.0),
//         ),
//         // color: colorCurve,
//         onPressed: () {
//           // Validate Email First
//           _validateInputs();
//         },
//       ),
//     );
//   }

//   String validateEmail(String value) {
//     RegExp regExp = RegExp(Constants.PATTERN_EMAIL, caseSensitive: false);

//     if (value.length == 0) {
//       return "Email is Required";
//     } else if (!regExp.hasMatch(value)) {
//       return "Enter valid email address.";
//     }
//     return null;
//   }

//   void _validateInputs() {
//     if (_formKey.currentState.validate()) {
// //    If all data are correct then save data to out variables
//       _formKey.currentState.save();
//       // Go to Dashboard
//     } else {
// //    If all data are not valid then start auto validation.
//       setState(() {
//         _autoValidate = true;
//       });
//     }
//   }
}
