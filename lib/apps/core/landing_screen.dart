import 'package:brandie_assessment/apps/core/landing_provider.dart';
import 'package:brandie_assessment/apps/favourites/favourites_screen.dart';
import 'package:brandie_assessment/apps/home/home_screen.dart';
import 'package:brandie_assessment/apps/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);
  final screens = [
    const HomeScreen(),
    // const FavouritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingProvider>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            return provider.implementDoubleTapExit();
          },
          child: Scaffold(
            body: IndexedStack(
              index: provider.selectedIndex,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              selectedFontSize: 12,
              currentIndex: provider.selectedIndex,
              onTap: provider.setSelectedIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.favorite_outline),
                //   activeIcon: Icon(Icons.favorite_rounded),
                //   label: 'Favourites',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
