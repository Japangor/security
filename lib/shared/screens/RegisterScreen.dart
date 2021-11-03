import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sc/shared/utils/AppColors.dart';
import 'package:sc/shared/utils/AppStyle.dart';
import 'package:sc/shared/screens/VerificationScreen.dart';

// ignore: camel_case_types
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

// ignore: camel_case_types
class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.1, left: 10, right: 10),
                  child: Image(
                    image: AssetImage('images/logo.png'),
                    height: size.height * 0.3,
                    width: size.width,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 4),
                Text('Create new account to get access to our services by entering your mobile number', style: secondaryTextStyle(size: 16, color: appTextColorSecondary.withOpacity(0.7))),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  decoration: boxDecorations(radius: 5, showShadow: true),
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(border: InputBorder.none, hintText: "Phone Number"),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 85),
                SDButton(
                  textContent: "CONTINUE",
                  onPressed: () {
                    VerficationScreen().launch(context);
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        persistentFooterButtons: <Widget>[
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 15, right: 15),
            width: MediaQuery.of(context).copyWith().size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Already have an account?', style: secondaryTextStyle()),
                TextButton(
                  onPressed: () {
                    finish(context);
                  },
                  child: Text('SIGN IN', style: boldTextStyle(size: 14, color: appColorPrimary)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
