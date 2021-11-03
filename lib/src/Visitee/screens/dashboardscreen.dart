import 'package:sc/shared/screens/company.dart';
import 'package:sc/src/Visitee/screens/checkout.dart';
import 'package:sc/src/Visitee/screens/visitorslist.dart';

import '../utils/SideDrawerWidget.dart';
import 'package:sc/shared/utils/AppWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sc/shared/utils/AppColors.dart';


class VisiteDashboard extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<VisiteDashboard> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();

    init();
  }


  init() async {


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
          title: Text('Visitee', style: boldTextStyle(color: appTextColorPrimary)),
        ),
        drawer: SideDrawer(),
        body: Center(
          child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: MaterialButton(
                          height: 100.0,
                          minWidth: 150.0,
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: const Text("Visitor List"),
                          onPressed: () => {
                            visitorlist().launch(context)

                          },
                          splashColor: Colors.redAccent,
                        )),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: MaterialButton(
                          height: 100.0,
                          minWidth: 150.0,
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: const Text("Company"),
                          onPressed: () => {
                            Company().launch(context)

                          },
                          splashColor: Colors.redAccent,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: MaterialButton(
                          height: 100.0,
                          minWidth: 150.0,
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: const Text("Checkout"),
                          onPressed: () => {
                            CheckOut().launch(context)

                          },
                          splashColor: Colors.redAccent,
                        )),
                  ],
                ),

              ]),),
    );
  }
}

