import 'dart:async';

import 'package:sc/shared/network/rest_apis.dart';
import 'package:sc/src/security/model/visitorlist.dart';
import 'package:sc/src/security/screens/visitordetails.dart';

import '../utils/sidedrawerwidget.dart';
import 'package:sc/shared/utils/AppWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sc/shared/utils/AppColors.dart';


class visitorlist extends StatefulWidget {
  @override
  visitorlistScreenState createState() => visitorlistScreenState();
}  late final List<visitorlistmodel> todos;


class visitorlistScreenState extends State<visitorlist> {
  int currentIndex = 0;
  Future<visitorlistmodel> ? visitlist;

  String ? secuirtyid;
  @override
  void initState() {
    super.initState();
    _loadUserInfo();

    init();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    secuirtyid = (prefs.getString('SecurityID') ?? "");
    setState(() {
      secuirtyid = (prefs.getString('SecurityID') ?? "");
    });

  }
  init() async {
    StreamSubscription _linkSubscription;

    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitor List', style: boldTextStyle(color: appTextColorPrimary)),
      ),
      drawer: SideDrawer(),
      body:   FutureBuilder<List<visitorlistmodel>>(
    future: getvisitlist(secuirtyid!,context),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    List<visitorlistmodel>? data = snapshot.data;
    return _jobsListView(data);
    } else if (snapshot.hasError) {
    return Text("${snapshot.error}");
    }
    return const CircularProgressIndicator();
    },
    )
    );
  }
}



ListView _jobsListView(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {


       return Card(          elevation: 5,
           child:          _tile(data[index].VisitorName, data[index].VisiteeName,data[index].VisitorPhoto,data[index].VisitorLocation,data[index].CheckInTime,data[index].VisitPurpose,data[index].CheckOutTime,data[index].CompanyName,data[index].VisitOutTime,data[index].VisiteeRemark,data[index].SecurityRemark,data[index].MobileNo,data[index].AddVisitors,context)

       );
      });
}

ListTile _tile(String VisitorName, String VisiteeName,String photo,String from,String CheckInTime,String VisitPurpose,String CheckOutTime,String Company,String VisitOutTime,String VisiteeRemark,String SecurityRemark,String MobileNo,String AddVisitors,context) => ListTile(
    leading:  CircleAvatar(
      backgroundImage: NetworkImage(photo.toString()), // no matter how big it is, it won't overflow
    ),


  title:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  <Widget>[  Text("Visitor Name: "+VisitorName,
          style: const TextStyle(color: Colors.black)),Text("To Meet: "+VisiteeName,style: const TextStyle(color: Colors.black),),Text("From: "+from,style: const TextStyle(color: Colors.black)),Text("CheckIN Time: "+CheckInTime,style: const TextStyle(color: Colors.black)),Text("Visit Purpose: "+VisitPurpose,style: const TextStyle(color: Colors.black)),_status(CheckOutTime,VisitorName,VisiteeName,VisitPurpose,Company,from,VisitOutTime,CheckOutTime,CheckInTime,SecurityRemark,VisiteeRemark,MobileNo,AddVisitors,photo,context)]
  )


);
_status(status,VisitPurpose,VisiteeName,VisitorName,CheckINTime,CheckOutTime,SecurityRemark,VisiteeRemark,VisitOutTime,from,company,MobileNo,AddVisitors,photo,context) {
  if (status != "") {
    return  ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blueGrey,),

      onPressed: () { Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  DetailScreen(),
          // Pass the arguments as part of the RouteSettings. The
          // DetailScreen reads the arguments from these settings.
          settings:  RouteSettings(
            // arguments:VisiteeName,
              arguments:[VisiteeName,VisitorName,CheckINTime,CheckOutTime,SecurityRemark,VisiteeRemark,from,company,VisitPurpose,VisitOutTime,AddVisitors,MobileNo,photo]
          ),
        ),
      ); },
      child: const Text('Checked OUT'),
    );
  } else if(status == "") {
    return ElevatedButton(

      onPressed: () { Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  DetailScreen(),
          // Pass the arguments as part of the RouteSettings. The
          // DetailScreen reads the arguments from these settings.
          settings:  RouteSettings(
            // arguments:VisiteeName,
              arguments:[VisiteeName,VisitorName,CheckINTime,CheckOutTime,SecurityRemark,VisiteeRemark,from,company,VisitPurpose,VisitOutTime,AddVisitors,MobileNo,photo]
          ),
        ),
      ); },
      child: const Text('Checked IN'),
    );
  } else {
    return Text("Waiting");
  }
}



