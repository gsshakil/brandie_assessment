import 'dart:convert';

import 'package:brandie_assessment/apps/product/product_model.dart';
import 'package:brandie_assessment/general/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  List<ProductModel> favourites = [];
  bool isFavourite = false;

  toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }

  void add(ProductModel product) async {
    toggleFavourite();
    favourites.add(product);
    notifyListeners();
    await SharedPrefs.saveproduct(jsonEncode(favourites));
    print(favourites);
  }

  void addAll(List<ProductModel> products) {
    favourites.addAll(products);
  }

  void remove(ProductModel removeItem) async {
    toggleFavourite();
    favourites =
        favourites.where((product) => product.id != removeItem.id).toList();
    await SharedPrefs.saveproduct(jsonEncode(favourites));
    print(favourites);
  }

  void removeAll() async {
    favourites = [];
    notifyListeners();
    await SharedPrefs.saveproduct(jsonEncode(favourites));
  }
}
