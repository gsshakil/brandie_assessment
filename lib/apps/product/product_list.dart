import 'package:brandie_assessment/apps/product/get_product_provider.dart';
import 'package:brandie_assessment/apps/product/product_card.dart';
import 'package:brandie_assessment/apps/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
    Provider.of<GetProductProvider>(context, listen: false).getProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetProductProvider>(
      builder: (context, product, child) {
        if (product.getResponseData().isEmpty) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: product.getResponseData().length,
          itemBuilder: (context, index) {
            var item = product.getResponseData()[index]['node'];
            return ProductCard(
              product: ProductModel(
                id: item['id'],
                name: item['name'],
                description: item['description'],
                imageUrl: item['thumbnail']['url'],
              ),
            );
          },
        );
      },
    );
  }
}
