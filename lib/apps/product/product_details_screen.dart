import 'package:brandie_assessment/apps/product/product_model.dart';
import 'package:brandie_assessment/apps/product/share_button_group.dart';
import 'package:brandie_assessment/general/constants/route_constants.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name ?? ''),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.favorite_outline_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        ],
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Image.network(product.imageUrl ?? ''),
              ),
              Text(product.name ?? ''),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              const SizedBox(height: 40),
              const Text('Reviews'),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('comment $index'),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteConstants.addReviewRoute);
        },
        child: const Icon(
          Icons.reviews,
          color: Colors.white,
        ),
      ),
    );
  }
}
