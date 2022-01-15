import 'dart:convert';

import 'package:brandie_assessment/apps/product/product_model.dart';
import 'package:brandie_assessment/general/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  List<ProductModel> favourites = [];

  void add(ProductModel product) async {
    favourites.add(product);
    notifyListeners();
    await SharedPrefs.saveproduct(jsonEncode(favourites));
    print(favourites);
  }

  void addAll(List<ProductModel> products) {
    favourites.addAll(products);
    notifyListeners();
  }

  void remove(ProductModel removeItem) async {
    favourites =
        favourites.where((product) => product.id != removeItem.id).toList();
    notifyListeners();
    await SharedPrefs.saveproduct(jsonEncode(favourites));
    print(favourites);
  }

  void removeAll() async {
    favourites = [];
    notifyListeners();
    await SharedPrefs.saveproduct(jsonEncode(favourites));
  }
}
