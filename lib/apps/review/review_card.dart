import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            //Heading...Profile Picture+ Name, Title, Time, More Button

            Row(
              children: [
                //Profile Pic and Name
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('url'),
                ),
                const SizedBox(width: 20),
                Text('Name Goes Here'),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            //Content Text
            Text('Contexkjdfg' * 10),

            const SizedBox(height: 10),

            //Images
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                'src',
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) {
                  return Center(
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
