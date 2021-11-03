import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sc/shared/network/rest_apis.dart';
import 'package:sc/shared/utils/AppWidget.dart';
import 'package:sc/shared/utils/AppColors.dart';
import 'package:sc/shared/utils/AppStyle.dart';
import 'package:sc/shared/screens/ForgotPwdScreen.dart';
import 'package:sc/shared/screens/RegisterScreen.dart';
import 'package:sc/src/Visitee/screens/dashboardscreen.dart';
import 'package:sc/src/security/screens/dashboardscreen.dart';
import 'package:sc/shared/network/rest_apis.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  String? token;

  gettoken() async{
  await Firebase.initializeApp();
  token = await FirebaseMessaging.instance.getToken();
}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    changeStatusColor(appLayout_background);
    gettoken();
loadUserInfo(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appLayout_background,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding:const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.1, left: 10, right: 10),
                    child: Image(
                      image: const AssetImage('images/logo.png'),
                      height: size.height * 0.3,
                      width: size.width,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: size.width,
                    decoration: boxDecorations(showShadow: true),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: username,

                          cursorColor: appTextColorSecondary.withOpacity(0.2),
                          cursorWidth: 1,
                          autocorrect: true,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: 'Username or Mobile number',
                            hintStyle: secondaryTextStyle(color: appTextColorSecondary.withOpacity(0.6)),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding:const EdgeInsets.only(left: 16, bottom: 16, top: 16, right: 16),
                          ),
                        ),
                        const  Divider(height: 1, thickness: 1),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                controller: password,

                                obscureText: true,
                                cursorColor: appTextColorSecondary.withOpacity(0.2),
                                cursorWidth: 1,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: secondaryTextStyle(color: appTextColorSecondary.withOpacity(0.6)),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:const EdgeInsets.only(left: 16, bottom: 16, top: 16, right: 16),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                ForgotPwdScreen().launch(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Text('Forgot?', style: boldTextStyle(size: 14, color: appColorPrimary)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 45),
                  SDButton(
                    textContent: "SIGN IN",
                    onPressed: () {
                      login(username.text, password.text,token.toString(),context);
                    },
                  ),
                  const  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        persistentFooterButtons: <Widget>[
          Container(
            height: 40,
            padding:const EdgeInsets.only(left: 15, right: 15),
            width: MediaQuery.of(context).copyWith().size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Don\'t have an account?', style: secondaryTextStyle()),
                TextButton(
                  onPressed: () {
                    RegisterScreen().launch(context);
                  },
                  child: Text('REGISTER', style: boldTextStyle(size: 14, color: appColorPrimary)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
