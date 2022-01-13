import 'package:brandie_assessment/apps/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name ?? ''),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Container(
                height: 200,
                child: Image.network(product.imageUrl ?? ''),
              ),
              Text(product.name ?? ''),
              const SizedBox(height: 20),
              Text(product.description ?? ''),
              const SizedBox(height: 20),
              Container(
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
              ),
              const SizedBox(height: 40),
              const Text('What people are saying about this product '),
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
    );
  }
}
