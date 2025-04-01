import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/custom_cached_network_image.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter_ecommerce/features/cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import 'package:flutter_ecommerce/features/cart/models/cart.dart';
import 'package:flutter_ecommerce/features/cart/widgets/cart_bloc_listener.dart';
import 'package:flutter_ecommerce/features/product/widgets/item_quantity_controller.dart';
import 'package:flutter_ecommerce/features/product/widgets/product_price.dart';
import 'package:gap/gap.dart';

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
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Card(
        // margin: EdgeInsets.zero,
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              _buildCheckBox(),
              Gap(4),
              _buildProductImage(),
              _buildProductDetail(context)
            ],
          ),
        ),
      ),
    );
  }

  Checkbox _buildCheckBox() {
    return Checkbox.adaptive(
        value: cart.isSelected,
        onChanged: (value) =>
            sl<GetCartBloc>().add(GetCartEvent.changeSelection(cart)));
  }

  Expanded _buildProductImage() {
    return Expanded(
        child: SizedBox(
      height: double.maxFinite,
      child: AppCachedNetworkImage(
        imageUrl: cart.product.images.firstOrNull?.url,
        fit: BoxFit.cover,
      ),
    ));
  }

  Expanded _buildProductDetail(BuildContext context) {
    return Expanded(
        flex: 2,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                          child: ProductPrice(
                              direction: Axis.vertical, product: cart.product)),
                      Spacer(),
                      _cartQuantity(),
                    ],
                  ),
                ])));
  }

  CartBlocListener _cartQuantity() {
    return CartBlocListener(
      bloc: _cartBloc,
      child: ItemQuantityController(
        getQuantity: (quantity) {},
        initialQuantity: cart.quantity,
        onDecrementQuantity: () => _cartBloc.add(CartEvent.update(
            id: cart.id, updatedTotalQuantity: cart.quantity - 1)),
        onIncrementQuantity: () => _cartBloc.add(
          CartEvent.update(
              id: cart.id, updatedTotalQuantity: cart.quantity + 1),
        ),
      ),
    );
  }
}
