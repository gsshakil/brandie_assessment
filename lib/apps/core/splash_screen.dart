import 'package:brandie_assessment/apps/authentication/login_screen.dart';
import 'package:brandie_assessment/apps/core/landing_screen.dart';
import 'package:brandie_assessment/apps/core/splash.dart';
import 'package:brandie_assessment/general/firebase_helpers/firebase_dynamic_link_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseDynamicLinkService.initDynamicLink(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 1000)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Splash();
        }
        return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Splash();
            } else if (snapshot.hasData) {
              return LandingScreen();
            } else {
              return const LoginScreen();
            }
          },
        );
      },
    );
  }
}
