import 'package:brandie_assessment/apps/core/landing_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 1000)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.amber,
            body: Center(
              child: Text(
                'Brandy',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        return const LandingScreen();
      },
    );
  }
}
