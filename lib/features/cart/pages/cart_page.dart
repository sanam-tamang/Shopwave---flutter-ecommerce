import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/common/widgets/app_loading.dart';
import 'package:flutter_ecommerce/features/cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import 'package:flutter_ecommerce/features/cart/models/cart.dart';
import 'package:flutter_ecommerce/features/cart/widgets/cart_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: BlocBuilder<GetCartBloc, GetCartState>(
        builder: (context, state) {
          return state.when(
              initial: () => SizedBox(),
              loading: () => AppLoading.center(),
              loaded: (carts) => _BuildCarts(
                    carts: carts,
                  ),
              failure: (failure) => Center(
                    child: Text(failure.toString()),
                  ));
        },
      ),
    );
  }
}

class _BuildCarts extends StatelessWidget {
  final List<Cart> carts;
  const _BuildCarts({
    required this.carts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      itemCount: carts.length,
      itemBuilder: (context, index) {
        final cart = carts[index];
        return CartCard(cart: cart);
      },
    );
  }
}
