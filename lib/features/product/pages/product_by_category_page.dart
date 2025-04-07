// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_ecommerce/features/category/models/category.dart';

class ProductByCategoryPage extends StatefulWidget {
  const ProductByCategoryPage({
    Key? key,
    required this.category,
  }) : super(key: key);
  final Category category;
  @override
  State<ProductByCategoryPage> createState() => _ProductByCategoryPageState();
}

class _ProductByCategoryPageState extends State<ProductByCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      
    );
  }
}
