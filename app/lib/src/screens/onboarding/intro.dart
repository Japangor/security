import 'dart:async';
import 'dart:convert';

import 'package:app/src/intromodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  String iconCode = 'f0fb';
  String data = 'fiveHundredPx';
  static const IconData clock = const IconDataRegular(0xf017);

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Future<intro> _intro;
  @override
  void initState() {
    super.initState();
    _intro = fetchintro();
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFF5B16D0),

        ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => print('Skip'),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                FutureBuilder<intro>(
                  future: _intro,
                  builder: (context, abc) {
                    if (abc.hasData) {
                      return Flexible(

                        child: PageView(


                          physics: ClampingScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          children: <Widget>[
                            Container(

                              color: Color(int.parse("0xff"+abc.data.bgColorSlide1)),
                              height:double.infinity,


                              padding: EdgeInsets.all(40.0),
                              child:
                               Column(

                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[

                                   Center(

                                     child: Center(
                                         child:Icon(IconDataSolid(getHexFromStr(abc.data.iconSlide1)),size: 50,)
                                     ),
                                   ),
                                   SizedBox(height: 30.0),
                                   Text(
                                     abc.data.headingSlide2,
                                   ),
                                   SizedBox(height: 15.0),
                                   Text(
                                     abc.data.textSlide2,
                                   ),
                                 ],


                              ),
                            ),
                            Container(
                              color: Color(int.parse("0xff"+abc.data.bgColorSlide2)),


                              padding: EdgeInsets.all(40.0),
                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Center(

                                    child: Center(
                                        child:Icon(IconDataSolid(getHexFromStr(abc.data.iconSlide2)))
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                  Text(
                                    abc.data.headingSlide2,
                                  ),
                                  SizedBox(height: 15.0),
                                  Text(
                                    abc.data.textSlide2,
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              color: Color(int.parse("0xff"+abc.data.bgColorSlide3)),


                              padding: EdgeInsets.all(40.0),
                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Center(

                                    child: Center(
                                        child:Icon(IconDataSolid(getHexFromStr(abc.data.iconSlide3)))
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                  Text(
                                    abc.data.headingSlide3,
                                  ),
                                  SizedBox(height: 15.0),
                                  Text(
                                    abc.data.textSlide3,
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    } else if (abc.hasError) {
                      return Text("${abc.error}");
                    }

                    // By default, it show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
        height: 100.0,
        width: double.infinity,
        color: Colors.white,
        child: GestureDetector(
          onTap: () => {
          Navigator.pushNamed(context, '/auth')

          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Get started',
                style: TextStyle(
                  color: Color(0xFF5B16D0),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),

              ),
            ),
          ),
        ),
      )
          : Text(''),
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
      throw new FormatException("An error occurred when converting");
    }
  }
  return val;
}