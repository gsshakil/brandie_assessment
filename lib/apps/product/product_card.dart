import 'package:brandie_assessment/apps/favourites/favourite_provider.dart';
import 'package:brandie_assessment/apps/product/product_details_screen.dart';
import 'package:brandie_assessment/apps/product/product_model.dart';
import 'package:brandie_assessment/apps/product/product_provider.dart';
import 'package:brandie_assessment/general/constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;
  final bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(context, product.id),
      child: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                RouteConstants.productDetailsRoute,
                arguments: ProductDetailsScreen(
                  product: ProductModel(
                    id: product.id,
                    description: product.description,
                    imageUrl: product.imageUrl,
                    name: product.name,
                  ),
                ),
              );
            },
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Image.network(
                            product.imageUrl ?? '',
                            errorBuilder: (c, o, s) {
                              return const Center(
                                child: Icon(Icons.error),
                              );
                            },
                          ),
                        ),
                        Text(
                          product.name!,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    // Consumer<FavouriteProvider>(
                    //   builder: (context, favouriteProvider, child) {
                    //     return Positioned(
                    //       right: 10,
                    //       child: IconButton(
                    //         onPressed: () {
                    //           productProvider.toggleFavourite();

                    //           !productProvider.isFavourite
                    //               ? favouriteProvider.remove(
                    //                   ProductModel(
                    //                     id: product.id,
                    //                     name: product.name,
                    //                     imageUrl: product.imageUrl,
                    //                     description: product.description,
                    //                   ),
                    //                 )
                    //               : favouriteProvider.add(
                    //                   ProductModel(
                    //                     id: product.id,
                    //                     name: product.name,
                    //                     imageUrl: product.imageUrl,
                    //                     description: product.description,
                    //                   ),
                    //                 );
                    //         },
                    //         icon: Icon(
                    //           productProvider.isFavourite
                    //               ? Icons.favorite_rounded
                    //               : Icons.favorite_outline_outlined,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
