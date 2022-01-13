import 'package:flutter/material.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: const Center(
        child: Text('Share your story with favourite brands'),
      ),
    );
  }
}
