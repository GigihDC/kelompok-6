import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../utils/utils.dart';
import 'page_forgotpass_verification.dart';

class PageForgotPassword extends StatefulWidget {
  @override
  _PageForgotPasswordState createState() => _PageForgotPasswordState();
}

class _PageForgotPasswordState extends State<PageForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  bool isLoading = false;

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
                        _forgotGradientText(),
                        SizedBox(height: size.getWidthPx(24)),
                        Header(),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.getWidthPx(16)),
                            child: _emailField())
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
          _passwordIconWidget(),
          SizedBox(height: size.getWidthPx(24)),
          Text(
            "Please fill your details below",
            style: TextStyle(
                fontFamily: 'Exo2',
                fontSize: 16.0,
                fontStyle: FontStyle.normal),
          ),
        ],
      );

  GradientText _forgotGradientText() {
    return GradientText('Forgot Password',
        gradient: LinearGradient(colors: [
          Color.fromRGBO(97, 6, 165, 1.0),
          Color.fromRGBO(45, 160, 240, 1.0)
        ]),
        style: TextStyle(
            fontFamily: 'Exo2', fontSize: 30, fontWeight: FontWeight.bold));
  }

  CircleAvatar _passwordIconWidget() {
    return CircleAvatar(
      maxRadius: size.getWidthPx(82),
      child: Image.asset("icons/imgforgot.png"),
      backgroundColor: colorCurve,
    );
  }

  BoxField _emailWidget() {
    return BoxField(
      hintText: "Enter email",
      lableText: "Email",
      obscureText: false,
      onSaved: (String val) {},
      validator: validateEmail,
      icon: Icons.email,
      iconColor: colorCurve,
    );
  }

  _emailField() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _emailWidget(),
          SizedBox(height: size.getWidthPx(20)),
          _submitButtonWidget(),
        ],
      );

  Container _submitButtonWidget() {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)),
        width: size.getWidthPx(200),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: colorCurve,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
          // elevation: 8.0,
          // padding: EdgeInsets.all(size.getWidthPx(12)),
          child: Text(
            "Submit",
            style: TextStyle(
                fontFamily: 'Exo2', color: Colors.white, fontSize: 20.0),
          ),
          // color: colorCurve,
          onPressed: () {
            // Validate Email First
            // _validateInputs();
            //Navigate to Forgot Password Screen...
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PageForgotPasswordVerification()));
          },
        ));
  }

  String validateEmail(String value) {
    RegExp regExp = RegExp(Constants.PATTERN_EMAIL, caseSensitive: false);

    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Enter valid email address.";
    }
    return null;
  }

//   void _validateInputs() {
//     if (_formKey.currentState.validate()) {
// //    If all data are correct then save data to out variables
//       _formKey.currentState.save();
//       GestureDetector(
//         onTap: () {
//           //Navigate to Forgot Password Screen...
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => PageForgotPasswordVerification()));
//         },
//       );
//       // Go to Dashboard
//     } else {
// //    If all data are not valid then start auto validation.
//       setState(() {
//         _autoValidate = true;
//       });
//     }
//   }
}
