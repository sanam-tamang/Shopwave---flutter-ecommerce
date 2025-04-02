import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/custom_cached_network_image.dart';
import 'package:flutter_ecommerce/features/product/widgets/product_price.dart';
import 'package:gap/gap.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorScheme.of(context).surfaceContainerLow,
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: double.maxFinite,
                child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: AppCachedNetworkImage(
                      imageUrl: product.images.firstOrNull?.url,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(8),
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(4),
                  FittedBox(
                    child: ProductPrice(
                        direction: Axis.vertical, product: product),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
