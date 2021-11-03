import 'package:flutter/material.dart';
import 'package:sc/shared/model/company.dart';
import 'package:sc/shared/network/rest_apis.dart';

import 'package:sc/src/security/model/visitorlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class Company extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<Company>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  late Future<company> companyy;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companyy = fetchcompany();

  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          title: const Text("Company"),
        ),
        body: FutureBuilder<company>(
          future: companyy,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return      Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, right: 25.0, top: 25.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children:  <Widget>[
                          Text("Company Name : "+
                            snapshot.data!.CompanyName,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("Company Desc : "+
                            snapshot.data!.CompanyDesc,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("Company Email : "+
                            snapshot.data!.Email,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("Company Phone : "+
                            snapshot.data!.Phone,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("Company Fax : "+
                            snapshot.data!.Fax,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("Company Web Address : "+
                            snapshot.data!.WebAddress,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                    ],
                  ));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

}