import 'package:brandie_assessment/apps/product/product_details_screen.dart';
import 'package:brandie_assessment/apps/product/product_model.dart';
import 'package:brandie_assessment/general/constants/route_constants.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;
  final bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
            ],
          ),
        ),
      ),
    );
  }
}
