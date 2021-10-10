// Security screen contents
import 'package:app/src/config/image_constants.dart';
import 'package:app/src/screens/onboarding/drawer.dart';
import 'package:app/src/utils/app_state_notifier.dart';
import 'package:app/src/widgets/cache_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared/main.dart';
import 'package:app/src/config/string_constants.dart' as string_constants;

class HomeScreen extends StatelessWidget {
  // ignore: close_sinks
  final AuthenticationBloc authenticationBloc =
      AuthenticationBlocController().authenticationBloc;

  @override
  Widget build(BuildContext context) {
    authenticationBloc.add(GetUserData());
    return WillPopScope(
        onWillPop: () async => false,
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            cubit: authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
              if (state is SetUserData) {
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      "Visitee",
                      style: Theme.of(context).appBarTheme.textTheme.bodyText1,
                    ),
                    actions: [
                      IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () {
                            authenticationBloc.add(UserLogOut());
                          }),
                    ],
                  ),
                  body: Center(
                    child: Column(
                      children: <Widget>[
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(20.0),
                            child: new MaterialButton(
                              height: 100.0,
                              minWidth: 150.0,
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: new Text("Visitor List"),
                              onPressed: () => {

                              },
                              splashColor: Colors.redAccent,
                            )),
                        Padding(
                            padding: EdgeInsets.all(20.0),
                            child: new MaterialButton(
                              height: 100.0,
                              minWidth: 150.0,
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: new Text("Visitor Details"),
                              onPressed: () => {

                              },
                              splashColor: Colors.redAccent,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(20.0),
                            child: new MaterialButton(
                              height: 100.0,
                              minWidth: 150.0,
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: new Text("Company"),
                              onPressed: () => {
                              },
                              splashColor: Colors.redAccent,
                            )),
                        Padding(
                            padding: EdgeInsets.all(20.0),
                            child: new MaterialButton(
                              height: 100.0,
                              minWidth: 150.0,
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: new Text("Checkout"),
                              onPressed: () => {

                              },
                              splashColor: Colors.redAccent,
                            )),
                      ],
                    ),

                      ]),),
                  drawer:navigationDrawer()
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }));
  }
}
