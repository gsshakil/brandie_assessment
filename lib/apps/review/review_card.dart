import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({this.snap, Key? key}) : super(key: key);

  final snap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Heading...Profile Picture+ Name, Title, Time, More Button
            Row(
              children: [
                //Profile Pic and Name
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(snap['profImage']),
                ),
                const SizedBox(width: 20),
                Text(snap['username'].toString()),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            //Content Text
            Text(snap['description']),

            const SizedBox(height: 20),

            //Images
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                snap['postUrl'].toString(),
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) {
                  return const Center(
                    child: Icon(Icons.error),
                  );
                },
              ),
            )

            //Replies/Comment
          ],
        ),
      ),
    );
  }
}
