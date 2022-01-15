import 'package:brandie_assessment/apps/favourites/favourite_provider.dart';
import 'package:brandie_assessment/apps/product/product_details_screen.dart';
import 'package:brandie_assessment/apps/product/product_model.dart';
import 'package:brandie_assessment/general/constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ProductModel item;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  initState() {
    var favIds = Provider.of<FavouriteProvider>(context, listen: false)
        .favourites
        .map((e) => e.id)
        .toList();

    if (favIds.contains(widget.item.id)) {
      isFavourite = true;
    }
  }

  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    final favouriteProvider =
        Provider.of<FavouriteProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          RouteConstants.productDetailsRoute,
          arguments: ProductDetailsScreen(
            product: ProductModel(
              id: widget.item.id,
              description: widget.item.description,
              imageUrl: widget.item.imageUrl,
              name: widget.item.name,
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
                      widget.item.imageUrl ?? '',
                      errorBuilder: (c, o, s) {
                        return const Center(
                          child: Icon(Icons.error),
                        );
                      },
                    ),
                  ),
                  Text(
                    widget.item.name!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              Positioned(
                right: 10,
                child: IconButton(
                  onPressed: () {
                    isFavourite
                        ? favouriteProvider.remove(
                            ProductModel(
                              id: widget.item.id,
                              name: widget.item.name,
                              imageUrl: widget.item.imageUrl,
                              description: widget.item.description,
                            ),
                          )
                        : favouriteProvider.add(
                            ProductModel(
                              id: widget.item.id,
                              name: widget.item.name,
                              imageUrl: widget.item.imageUrl,
                              description: widget.item.description,
                            ),
                          );
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  },
                  icon: Icon(isFavourite
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
