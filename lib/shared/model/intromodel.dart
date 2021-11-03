import 'dart:convert';
import 'package:http/http.dart' as http;
import '../network/rest_apis.dart';

class IntroModel {
  String success ="";
  String iconSlide1="";
  String iconSlide2="";
  String iconSlide3="";
  String headingSlide1="";
  String headingSlide2="";
  String headingSlide3="";
  String textSlide1="";
  String textSlide2="";
  String textSlide3="";
  String bgColorSlide1="";
  String bgColorSlide2="";
  String bgColorSlide3="";

  IntroModel(
      {required this.success,
        required this.iconSlide1,
        required this.iconSlide2,
        required this.iconSlide3,
        required this.headingSlide1,
        required  this.headingSlide2,
        required  this.headingSlide3,
        required  this.textSlide1,
        required this.textSlide2,
        required this.textSlide3,
        required  this.bgColorSlide1,
        required  this.bgColorSlide2,
        required  this.bgColorSlide3});

  IntroModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    iconSlide1 = json['IconSlide1'];
    iconSlide2 = json['IconSlide2'];
    iconSlide3 = json['IconSlide3'];
    headingSlide1 = json['HeadingSlide1'];
    headingSlide2 = json['HeadingSlide2'];
    headingSlide3 = json['HeadingSlide3'];
    textSlide1 = json['TextSlide1'];
    textSlide2 = json['TextSlide2'];
    textSlide3 = json['TextSlide3'];
    bgColorSlide1 = json['BgColorSlide1'];
    bgColorSlide2 = json['BgColorSlide2'];
    bgColorSlide3 = json['BgColorSlide3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['IconSlide1'] = iconSlide1.toString();
    data['IconSlide2'] = iconSlide2;
    data['IconSlide3'] = iconSlide3;
    data['HeadingSlide1'] = headingSlide1;
    data['HeadingSlide2'] = headingSlide2;
    data['HeadingSlide3'] = headingSlide3;
    data['TextSlide1'] = textSlide1;
    data['TextSlide2'] = textSlide2;
    data['TextSlide3'] = textSlide3;
    data['BgColorSlide1'] = bgColorSlide1;
    data['BgColorSlide2'] = bgColorSlide2;
    data['BgColorSlide3'] = bgColorSlide3;
    return data;
  }
}
