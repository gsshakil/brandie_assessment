import 'package:brandie_assessment/apps/favourites/favourite_provider.dart';
import 'package:brandie_assessment/apps/product/product_model.dart';
import 'package:brandie_assessment/apps/product/product_provider.dart';
import 'package:brandie_assessment/apps/review/review_card.dart';
import 'package:brandie_assessment/general/constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final favouriteProvider =
        Provider.of<FavouriteProvider>(context, listen: false);
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(context, product.id),
      child: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(product.name ?? ''),
              actions: [
                IconButton(
                  onPressed: () {
                    productProvider.toggleFavourite();

                    !productProvider.isFavourite
                        ? favouriteProvider.remove(
                            ProductModel(
                              id: product.id,
                              name: product.name,
                              imageUrl: product.imageUrl,
                              description: product.description,
                            ),
                          )
                        : favouriteProvider.add(
                            ProductModel(
                              id: product.id,
                              name: product.name,
                              imageUrl: product.imageUrl,
                              description: product.description,
                            ),
                          );
                  },
                  icon: Icon(
                    productProvider.isFavourite
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                ),
              ],
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Image.network(product.imageUrl ?? ''),
                      ),
                      Text(product.name ?? ''),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const ReviewCard();
                    },
                  ),
                ),
              ],
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
        },
      ),
    );
  }
}
