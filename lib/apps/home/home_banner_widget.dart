import 'package:brandie_assessment/apps/search/search_screen.dart';
import 'package:flutter/material.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 150,
          ),
          const SizedBox(height: 40),
          Text(
            'Share your story on our products',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 20),
          Container(
            height: 48,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
                  offset: Offset(0, 14),
                  blurRadius: 28,
                ),
              ],
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            child: MaterialButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchScreen(),
                );
              },
              child: Row(
                children: const [
                  Icon(Icons.search),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Search'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
