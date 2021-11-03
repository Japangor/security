//region imports

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sc/shared/utils/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sc/shared/store/AppStore.dart';
import 'package:sc/shared/utils/AppTheme.dart';
import 'package:sc/shared/screens/SplashScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sc/src/security/screens/visitorslist.dart';
//endregion

/// This variable is used to get dynamic colors when theme mode is changed
AppStore appStore = AppStore();
Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  String? token = await FirebaseMessaging.instance.getToken();
  print("TOKEN: "+token!);

  await FirebaseMessaging.instance.subscribeToTopic("securtiy");
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print("message recieved");
    print(event.notification!);
  });
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onMessageOpenedApp.listen((message) {


    print('Message clicked!'+message.data.toString());
  });



  runApp(MyApp());
  //endregion
}
void _handleMessage(RemoteMessage message,context) {
  if (message.data['type'] == 'chat') {
    print(message);

  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Observer(

      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,

      ),
    );
  }
}
