import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/custom_cached_network_image.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce/features/cart/models/cart.dart';
import 'package:flutter_ecommerce/features/cart/widgets/cart_bloc_listener.dart';

import 'package:flutter_ecommerce/features/product/widgets/item_quantity_controller.dart';
import 'package:flutter_ecommerce/features/product/widgets/product_price.dart';

class CartCard extends StatelessWidget {
   CartCard({
    super.key,
    required this.cart,
  });

  final Cart cart;
  final CartBloc _cartBloc = sl<CartBloc>(); 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        margin: EdgeInsets.zero,
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: SizedBox(
          height: 210,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: double.maxFinite,
                    child: AppCachedNetworkImage(
                      imageUrl: cart.product.images.firstOrNull?.url,
                      fit: BoxFit.cover,
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cart.product.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              cart.product.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey),
                            ),
                            FittedBox(
                                child: ProductPrice(product: cart.product)),
                            CartBlocListener(
                              bloc: _cartBloc,
                              child: ItemQuantityController(
                                getQuantity: (quantity) {},
                                initialQuantity: cart.quantity,
                                onDecrementQuantity: () => _cartBloc.add(
                                    CartEvent.update(
                                        id: cart.id,
                                        updatedTotalQuantity:
                                            cart.quantity - 1)),
                                onIncrementQuantity: () => _cartBloc.add(
                                  CartEvent.update(
                                      id: cart.id,
                                      updatedTotalQuantity: cart.quantity + 1),
                                ),
                              ),
                            ),
                          ])))
            ],
          ),
        ),
      ),
    );
  }
}
