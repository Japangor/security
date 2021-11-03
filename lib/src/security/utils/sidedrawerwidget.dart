
import 'package:get/get.dart';
import 'package:sc/shared/network/rest_apis.dart';
import 'package:sc/shared/screens/loginscreen.dart';
import 'package:sc/src/security/model/securityprofile.dart';
import 'package:sc/src/security/screens/dashboardscreen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sc/src/security/model/SideDrawerModel.dart';


class SideDrawer extends StatefulWidget {
  static String tag = '/SideDrawer';

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  List<DrawerModel> getDrawerList = _getDrawerList();
  int currentIndex = 0;
   Future<securityprofile> ? profile;
   String ? secuirtyid;

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     secuirtyid = (prefs.getString('SecurityID') ?? "");
    setState(() {
      secuirtyid = (prefs.getString('SecurityID') ?? "");
    });
    profile = getsecurityprofile(secuirtyid.toString(),context);

  }
  @override
  void initState() {
    _loadUserInfo();

    super.initState();

    init();
  }
  init() async {
    await Future.delayed(Duration(seconds: 1));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ClipPath(
        clipper: OvalRightBorderClipper(),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<securityprofile>(
              future: profile,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return   UserAccountsDrawerHeader(
                    margin: EdgeInsets.all(0),
                    accountName: Text(snapshot.data!.SecurityPersonnelName, style: boldTextStyle(color: Colors.white)),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data!.Photo),
                      radius: 40,
                    ),
                    accountEmail: Text(snapshot.data!.Email),

                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),

            10.height,
            Container(
              child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: getDrawerList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: getDrawerList[index].isSelected ? Colors.blueGrey.withOpacity(0.3) : transparentColor,
                      child: createBasicListTile(
                        text: getDrawerList[index].title!,
                        icon: getDrawerList[index].icon,
                        onTap: () {
                          if (currentIndex == index) {
                            finish(context);
                          } else {
                            currentIndex = index;
                            if (getDrawerList[index].title != "Setting" && getDrawerList[index].title != "Upgrade Account") {
                              getDrawerList.forEach((element) {
                                element.isSelected = false;
                              });
                            }
                            getDrawerList[index].isSelected = true;
                            getDrawerList.elementAt(getDrawerList.length - 1).isSelected = false;
                            getDrawerList.elementAt(getDrawerList.length - 2).isSelected = false;

                            finish(context);
                            if (getDrawerList[index].title == "Logout") {
                              getDrawerList[index].goto.launch(
                                  logout(context), isNewTask: true);
                            }
                            else if (getDrawerList[index].title == "Dashboard") {
                              getDrawerList[index].goto.launch(
                                  dashboard(context), isNewTask: true);
                            }
                            // } else {
                            //   getDrawerList[index].goto.launch(context);
                            // }
                            getDrawerList[index].goto.launch(context);
                          }
                        },
                      ).paddingSymmetric(horizontal: 16),
                    );
                  }),
            ),
          ],
        ),
      ),
    ),
        ),
    );
  }


}
List<DrawerModel> _getDrawerList() {
  List<DrawerModel> _drawerModel = [];
  _drawerModel.add(DrawerModel(title: "Dashboard", icon: Icons.home, goto: SecurityScreen()));
  _drawerModel.add(DrawerModel(title: "Logout", icon: Icons.verified_user));
  //_drawerModel.add(DrawerModel(title: "Files", icon: Icons.folder, goto: CSCommonFileComponents(appBarTitle: CSAppName)));

  return _drawerModel;
}

dashboard(context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => SecurityScreen()));
}