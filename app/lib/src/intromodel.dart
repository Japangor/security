import 'dart:convert';

import 'package:http/http.dart' as http;
class intro {
  String success;
  String iconSlide1;
  String iconSlide2;
  String iconSlide3;
  String headingSlide1;
  String headingSlide2;
  String headingSlide3;
  String textSlide1;
  String textSlide2;
  String textSlide3;
  String bgColorSlide1;
  String bgColorSlide2;
  String bgColorSlide3;

  intro(
      {this.success,
        this.iconSlide1,
        this.iconSlide2,
        this.iconSlide3,
        this.headingSlide1,
        this.headingSlide2,
        this.headingSlide3,
        this.textSlide1,
        this.textSlide2,
        this.textSlide3,
        this.bgColorSlide1,
        this.bgColorSlide2,
        this.bgColorSlide3});

  intro.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['IconSlide1'] = this.iconSlide1.toString();
    data['IconSlide2'] = this.iconSlide2;
    data['IconSlide3'] = this.iconSlide3;
    data['HeadingSlide1'] = this.headingSlide1;
    data['HeadingSlide2'] = this.headingSlide2;
    data['HeadingSlide3'] = this.headingSlide3;
    data['TextSlide1'] = this.textSlide1;
    data['TextSlide2'] = this.textSlide2;
    data['TextSlide3'] = this.textSlide3;
    data['BgColorSlide1'] = this.bgColorSlide1;
    data['BgColorSlide2'] = this.bgColorSlide2;
    data['BgColorSlide3'] = this.bgColorSlide3;
    return data;
  }
}
Future<intro> fetchintro() async {
  final response =
  await http.get('https://visitorpass.theiis.com/api/IntroSlidesAPI');

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    return intro.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load post');
  }
}
