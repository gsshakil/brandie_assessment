import 'package:brandie_assessment/apps/favourites/favourite_provider.dart';
import 'package:brandie_assessment/apps/product/product_model.dart';
import 'package:brandie_assessment/apps/product/product_provider.dart';
import 'package:brandie_assessment/apps/review/add_review_screen.dart';
import 'package:brandie_assessment/apps/review/review_card.dart';
import 'package:brandie_assessment/general/constants/route_constants.dart';
import 'package:brandie_assessment/general/utils/firebase_dynamic_link_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

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
                // IconButton(
                //   onPressed: () {
                //     productProvider.toggleFavourite();

                //     !productProvider.isFavourite
                //         ? favouriteProvider.remove(
                //             ProductModel(
                //               id: product.id,
                //               name: product.name,
                //               imageUrl: product.imageUrl,
                //               description: product.description,
                //             ),
                //           )
                //         : favouriteProvider.add(
                //             ProductModel(
                //               id: product.id,
                //               name: product.name,
                //               imageUrl: product.imageUrl,
                //               description: product.description,
                //             ),
                //           );
                //   },
                //   icon: Icon(
                //     productProvider.isFavourite
                //         ? Icons.favorite_rounded
                //         : Icons.favorite_outline_outlined,
                //   ),
                // ),
                IconButton(
                  onPressed: () async {
                    String uri = await FirebaseDynamicLinkService
                        .createProductDynamicLinks(product);
                    Share.share(uri.toString());
                  },
                  icon: const Icon(Icons.share),
                ),
              ],
            ),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        SizedBox(
                          height: 200,
                          child: Image.network(product.imageUrl ?? ''),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          product.name ?? '',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: 50),
                        const Divider(),
                        Text('What people are saying about this item',
                            style: Theme.of(context).textTheme.bodyText1),
                        const Divider(),
                      ],
                    ),
                  ),
                ];
              },
              body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('reviews')
                    .doc(product.id)
                    .collection('reviews')
                    .snapshots(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return snapshot.data!.docs.isEmpty
                        ? const Center(
                            child: Text('Nothing Found'),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return ReviewCard(
                                snap: snapshot.data!.docs[index].data(),
                              );
                            },
                          );
                  }
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  RouteConstants.addReviewRoute,
                  arguments: AddReviewScreen(
                    productId: product.id!,
                  ),
                );
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
