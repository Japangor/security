import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sc/shared/model/intromodel.dart';
import 'package:sc/shared/network/rest_apis.dart';
import 'package:sc/shared/utils/AppColors.dart';
import 'package:sc/shared/screens/loginscreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sc/src/security/screens/dashboardscreen.dart';
import 'package:sc/src/Visitee/screens/dashboardscreen.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();

}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  bool? isActive;
  PageController pageController = PageController(initialPage: 0);
  int pageChanged = 0;
  late Future<IntroModel> _intro;
  @override
  void initState() {
    super.initState();
    loadUserInfo(context);

    _intro = fetchintro();
  }
  List<Widget> buildDotIndicator() {
    List<Widget> list = [];
    for (int i = 0; i <= 2; i++) {
      list.add(i == pageChanged ? sDDotIndicator(isActive: true) : sDDotIndicator(isActive: false));
    }

    return list;
  }



  Widget sDDotIndicator({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: isActive ? 8.0 : 6.0,
      width: isActive ? 8.0 : 6.0,
      decoration: BoxDecoration(color: isActive ? appColorPrimary : const Color(0xFF7E869B), borderRadius: const BorderRadius.all(Radius.circular(50))),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(

        body: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
        FutureBuilder<IntroModel>(
        future: _intro,
        builder: (context, abc) {
          if(abc.hasData)
            {
              return SizedBox(
                height: size.height * 0.7,
                child: PageView(

                  onPageChanged: (index) {
                    setState(() {
                      pageChanged = index;
                    });
                  },
                  controller: pageController,

                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.1, left: 10, right: 10),
                          child:Icon(IconDataSolid(getHexFromStr(abc.data!.iconSlide1))),
                        ),
                        const SizedBox(height: 4),
                        Center(
                          child: Padding(padding: const EdgeInsets.only(top: 40), child: Text(abc.data!.headingSlide1, textAlign: TextAlign.center, style: boldTextStyle(size: 25))),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: size.height * 0.1, left: 10, right: 10),
                            child: Icon(IconDataSolid(getHexFromStr(abc.data!.iconSlide2)))
                        ),
                        const SizedBox(height: 4),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text(abc.data!.headingSlide2, textAlign: TextAlign.center, style: boldTextStyle(size: 25)),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: size.height * 0.1, left: 10, right: 10),
                            child: Icon(IconDataSolid(getHexFromStr(abc.data!.iconSlide3)))
                        ),
                        const  SizedBox(height: 4),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text(abc.data!.headingSlide3, textAlign: TextAlign.center, style: boldTextStyle(size: 25)),
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Padding(
                          padding:const EdgeInsets.only(left: 40, right: 40),
                          child: Text('More text follows \nhere as per your content', textAlign: TextAlign.justify, style: secondaryTextStyle(size: 16)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          return Container();

        }),

            SizedBox(
              height: 40,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: buildDotIndicator()),
            ),
            Container(
              margin:const EdgeInsets.only(bottom: 20),
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  pageChanged != 2
                      ? InkWell(
                    child: const CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                      backgroundColor: appColorPrimary,
                    ),
                    onTap: () {
                      pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
                    },
                  )
                      : Container(
                    margin: const EdgeInsets.only(bottom: 0, left: 20, right: 20),
                    width: size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: appColorPrimary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 1,
                      ),
                      onPressed: () {
                        finish(context);
                        loadUserInfo(context);
                        const LoginScreen().launch(context);
                      },
                      child: Text(
                        "GET STARTED",
                        textAlign: TextAlign.center,
                        style: boldTextStyle(size: 16, color: Colors.white, letterSpacing: 2),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
int getHexFromStr(String fontCode) {
  int val = 0;
  int len = fontCode.length;
  for (int i = 0; i < len; i++) {
    int hexDigit = fontCode.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
      // A..F
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
      // a..f
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      throw const FormatException("An error occurred when converting");
    }
  }
  return val;
}
