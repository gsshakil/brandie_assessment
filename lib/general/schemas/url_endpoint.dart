import 'package:brandie_assessment/general/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EndPoint {
  ValueNotifier<GraphQLClient> getClient() {
    ValueNotifier<GraphQLClient> _client = ValueNotifier(
      GraphQLClient(
        link: HttpLink(endpointUrl),
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );

    return _client;
  }
}
