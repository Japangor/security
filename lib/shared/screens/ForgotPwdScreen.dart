import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sc/shared/utils/AppColors.dart';
import 'package:sc/shared/utils/AppStyle.dart';
import 'package:sc/shared/screens/loginscreen.dart';

class ForgotPwdScreen extends StatefulWidget {
  @override
  _ForgotPwdScreenState createState() => _ForgotPwdScreenState();
}

class _ForgotPwdScreenState extends State<ForgotPwdScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: context.height(),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 100, left: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Password reset', style: boldTextStyle(size: 25)),
                SizedBox(height: 25),
                Text('Enter email address to send reset code', style: secondaryTextStyle(size: 16, color: appTextColorSecondary.withOpacity(0.7))),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 8, bottom: 8),
                  decoration: boxDecorations(radius: 5, showShadow: true),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(border: InputBorder.none, hintText: "Email Address"),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 30),
                SDButton(
                  textContent: "SEND",
                  onPressed: () {
                    LoginScreen().launch(context);
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
                Text('Remember password?', style: secondaryTextStyle()),
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
