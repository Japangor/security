import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sc/integrations/models/follower_model.dart';
import 'package:sc/shared/model/company.dart';
import 'package:sc/shared/model/intromodel.dart';
import 'package:sc/src/Visitee/model/visiteeprofile.dart';
import 'package:sc/src/Visitee/model/visitorlist.dart';
import 'package:sc/src/security/model/addvisitormodel.dart';
import 'package:sc/shared/screens/loginscreen.dart';
import 'package:sc/shared/utils/AppConstant.dart';
import 'package:sc/shared/utils/confetti/src/helper.dart';
import 'package:sc/src/Visitee/screens/dashboardscreen.dart';
import 'package:sc/src/security/model/securityprofile.dart';
import 'package:sc/src/security/model/visitorlist.dart';
import 'package:sc/src/security/screens/dashboardscreen.dart';
import 'config.dart';
import 'network_utils.dart';
import 'package:http/http.dart' as http;

/// GET method demo
Future<List<FollowerModel>> getFollowers() async {
  var result = await handleResponse(await getRequest('$baseURL/users/octocat/followers'));

  Iterable list = result;
  return list.map((model) => FollowerModel.fromJson(model)).toList();
}

/// POST method demo
Future createEmployee(Map req) async {
  return handleResponse(await postRequest('http://dummy.restapiexample.com/api/v1/create', req));
}
Future<IntroModel> fetchintro() async {
  DebugPrintCallback debugPrint = debugPrintThrottled;

  final response =
  await http.get(Uri.parse(introslides));

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    return IntroModel.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load post');
  }
}
Future<http.Response> login(String username, String password,String token,context) {
  return getRequest(loginURL+"?username="+username+"&password="+password+"&devicetoken="+token).then((dynamic res) async{
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);

      if (data["SecurityID"] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("SecurityID", data["SecurityID"]);
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => SecurityScreen()));


      }
      else if (data["VisiteeID"] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("VisiteeID", data["VisiteeID"]);
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => VisiteDashboard()));

      }
    }
    return res;
  });
}

Future<List<visitortype>> getvisitortype(String endpoint) async {
  http.Response response = await http.get(Uri.parse(endpoint));
  String body = response.body;

  List data = json.decode(body);
  return data.map((e) => visitortype.fromJson(e)).toList();
}
Future<List<planttype>> getplants(String endpoint) async {
  http.Response response = await http.get(Uri.parse(endpoint));
  String body = response.body;

  List data = json.decode(body);
  return data.map((e) => planttype.fromJson(e)).toList();
}
Future<List<persontomeetmodel>> getpersontomeet(String endpoint) async {
  http.Response response = await http.get(Uri.parse(endpoint));
  String body = response.body;

  List data = json.decode(body);
  return data.map((e) => persontomeetmodel.fromJson(e)).toList();
}
Future<List<gatemodel>> getgate(String endpoint) async {
  http.Response response = await http.get(Uri.parse(endpoint));
  String body = response.body;

  List data = json.decode(body);
  return data.map((e) => gatemodel.fromJson(e)).toList();
}
Future<List<departmentmodel>> getdepartment(String endpoint) async {
  http.Response response = await http.get(Uri.parse(endpoint));
  String body = response.body;

  List data = json.decode(body);
  return data.map((e) => departmentmodel.fromJson(e)).toList();
}
Future postvisitor(Map req) async {
  return handleResponse(await postRequest(addvisitorpostapi, req));
}

Future<securityprofile> getsecurityprofile(String securityid,context) async{
  http.Response response = await http.get(Uri.parse(SecurityProfileApi+"?SecurityID="+securityid));
  String body = response.body;
  print(body);

  return securityprofile.fromJson(jsonDecode(response.body));



}
Future<visiteeprofile> getvisiteeprofile(String visite,context) async{
  http.Response response = await http.get(Uri.parse(visiteeProfileApi+"?VisiteeID="+visite));
  String body = response.body;

  return visiteeprofile.fromJson(jsonDecode(response.body));



}

Future<List<visitorlistmodel>> getvisitlist(String SecurityId,context) async {
  //for Secuirty

  http.Response response = await http.get(Uri.parse(visitors+"?SecurityId="+SecurityId));
  String body = response.body;


  List data = json.decode(body);
  print(data[0]);
  return data.map((e) => visitorlistmodel.fromJson(e)).toList();
}
Future<List<visitorlistmodelvisitee>> getvisitlist2(String VisiteeID,context) async {
  //for visitee
  http.Response response = await http.get(Uri.parse(visitors+"?VisiteeID="+VisiteeID));
  String body = response.body;
  List data = json.decode(body);
  return data.map((e) => visitorlistmodelvisitee.fromJson(e)).toList();
}
Future<company> fetchcompany() async {
  final response = await http
      .get(Uri.parse(companyapi));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return company.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load company');
  }
}

logout(context) async {
  String _securityid,visitid;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('SecurityID',"");
  prefs.setString('VisiteeID',"");
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginScreen()));



}
Future checkout(Map req) async {
  return handleResponse(await postRequest(checkoutapi, req));
}




uploadFile() async {
  var postUri = Uri.parse(addvisitorpostapi);



}
loadUserInfo(context) async {
  String _securityid,visitid;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _securityid = (prefs.getString('SecurityID') ?? "");
  visitid = (prefs.getString('VisiteeID') ?? "");

  if(_securityid!="")
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) =>  SecurityScreen()));

  }
  else if(visitid!=""){
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => VisiteDashboard()));
  }

}
