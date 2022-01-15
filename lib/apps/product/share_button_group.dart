import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ShareButtonGroup extends StatelessWidget {
  const ShareButtonGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
          ),
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: const Icon(Icons.favorite),
            ),
          ),
          Expanded(
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: const Icon(Icons.comment),
            ),
          ),
          Expanded(
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Share.share('text');
              },
              child: const Text('Share'),
            ),
          ),
        ],
      ),
    );
  }
}
