import 'package:brandie_assessment/apps/home/home_banner_widget.dart';
import 'package:brandie_assessment/apps/product/product_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          HomeBannerWidget(),
          ProductList(),
        ],
      ),
    );
  }
}
