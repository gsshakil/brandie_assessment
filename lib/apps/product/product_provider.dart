import 'package:brandie_assessment/apps/favourites/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier {
  bool isFavourite = false;

  toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }

  ProductProvider() {
    // var favIds = Provider.of<FavouriteProvider>(context, listen: false)
    //     .favourites
    //     .map((e) => e.id)
    //     .toList();

    // if (favIds.contains(id)) {
    //   isFavourite = true;
    // }
  }
}
