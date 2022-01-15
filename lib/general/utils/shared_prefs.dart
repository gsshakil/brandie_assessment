import 'package:brandie_assessment/general/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static saveproduct(products) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.favouriteKey, products);
  }

  static Future<dynamic> getproduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var productData = prefs.getString(Constants.favouriteKey);
    return productData;
  }
}
