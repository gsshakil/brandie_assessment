import 'package:brandie_assessment/general/schemas/product_schema.dart';
import 'package:brandie_assessment/general/schemas/url_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GetProductProvider extends ChangeNotifier {
  bool _status = false;

  String _response = '';

  dynamic _list = [];

  bool isLoading = false;

  bool get getStatus => _status;

  String get getResponse => _response;

  final EndPoint _point = EndPoint();

  void setloading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void getProducts(bool isLocal) async {
    ValueNotifier<GraphQLClient> _client = _point.getClient();

    QueryResult result = await _client.value.query(
      QueryOptions(
        document: gql(ProductSchema.productsGraphQL),
        fetchPolicy: isLocal == true ? null : FetchPolicy.networkOnly,
      ),
    );

    if (result.isLoading) {
      setloading(true);
    }

    if (result.hasException) {
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = "Internet is not found";
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      setloading(false);
      _status = false;
      _list = result.data;
      notifyListeners();
    }
  }

  dynamic getResponseData() {
    if (_list.isNotEmpty) {
      final data = _list;

      return data?['products']['edges'] ?? {};
    } else {
      return {};
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
