// routes for the app
import 'package:app/src/screens/Visitee/visiteindex.dart';
import 'package:app/src/screens/Security/securityindex.dart';
import 'package:app/src/screens/onboarding/intro.dart';
import 'package:app/src/screens/onboarding/authentication_screen.dart';
import 'package:app/src/splash_screen.dart';
import 'package:flutter/material.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => SplashScreen());
    case '/Security':
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case '/security':
      return MaterialPageRoute(builder: (_) => Security());
    case '/intro':
      return MaterialPageRoute(builder: (_) => OnboardingScreen());
    case '/auth':
      return MaterialPageRoute(builder: (_) => AuthenticationScreen());
    default:
      return MaterialPageRoute(builder: (_) => SplashScreen());
  }
}
