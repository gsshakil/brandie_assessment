import 'package:brandie_assessment/apps/home/home_banner_widget.dart';
import 'package:brandie_assessment/apps/product/product_details_screen.dart';
import 'package:brandie_assessment/apps/product/product_model.dart';
import 'package:brandie_assessment/general/constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const productsGraphQL = """
    query products{
      products(first: 10, channel: "default-channel") {
          edges {
            node {
              id
              name
              description
              thumbnail{
                url
              }
            }
          }
        }
    } 
  """;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView(
        children: [
          const HomeBannerWidget(),
          Query(
            options: QueryOptions(
              document: gql(productsGraphQL),
            ),
            builder: (QueryResult result, {fetchMore, refetch}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }
              if (result.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final productList = result.data?['products']['edges'];
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  var product = productList[index]['node'];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RouteConstants.productDetailsRoute,
                        arguments: ProductDetailsScreen(
                          product: ProductModel(
                            id: product['id'],
                            description: product['description'],
                            imageUrl: product['thumbnail']['url'],
                            name: product['name'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              child: Image.network(product['thumbnail']['url']),
                            ),
                            Text(product['name']),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
