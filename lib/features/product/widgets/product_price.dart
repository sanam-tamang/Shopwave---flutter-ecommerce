// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_ecommerce/features/product/models/product.dart';
import 'package:gap/gap.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.product,
    this.direction = Axis.horizontal,
  });

  final Product product;
  final Axis direction;
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: direction,
      children: [
        if (product.discountPrice != null) ...[
          Text(
            '\$${product.discountPrice!.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorScheme.of(context).onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Gap(8),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: ColorScheme.of(context).secondary,
                  decoration: TextDecoration.lineThrough,
                ),
          ),
        ] else
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorScheme.of(context).onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
      ],
    );
  }
}
