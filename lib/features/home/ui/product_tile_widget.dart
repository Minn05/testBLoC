// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:test/features/home/models/home_product_model.dart';

class ProDuctTileWidget extends StatelessWidget {
  final ProductModel productModel;

  const ProDuctTileWidget({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.shade100),
      child: Column(
        children: [
          Text(productModel.name),
          Text(productModel.description),
          Image.network(productModel.imageUrl)
        ],
      ),
    );
  }
}
