import 'package:brandie_assessment/apps/favourites/favourite_provider.dart';
import 'package:brandie_assessment/apps/product/product_card.dart';
import 'package:brandie_assessment/apps/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteProvider>(
      builder: (context, favourite, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Favourites'),
            actions: [
              IconButton(
                onPressed: () {
                  favourite.removeAll();
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          body: favourite.favourites.isEmpty
              ? const Center(
                  child: Text('No Item Found!'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: favourite.favourites.length,
                  itemBuilder: (context, index) {
                    var item = favourite.favourites[index];
                    return ProductCard(
                      item: ProductModel(
                        id: item.id,
                        name: item.name,
                        description: item.description,
                        imageUrl: item.imageUrl,
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
