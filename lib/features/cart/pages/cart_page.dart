import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/common/widgets/app_loading.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import 'package:flutter_ecommerce/features/cart/models/cart.dart';
import 'package:flutter_ecommerce/features/cart/widgets/cart_card.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My cart"),
      ),
      body: BlocBuilder<GetCartBloc, GetCartState>(
        builder: (context, state) {
          return state.when(
              initial: () => SizedBox(),
              loading: () => AppLoading.center(),
              loaded: (data) => _BuildCarts(
                    carts: data.carts,
                  ),
              failure: (failure) => Center(
                    child: Text(failure.toString()),
                  ));
        },
      ),
      bottomNavigationBar: _BottomSheet(),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCartBloc, GetCartState>(
      builder: (context, state) {
        return state.maybeWhen(
            loaded: (data) => data.carts.isEmpty
                ? SizedBox()
                : Container(
                    color: ColorScheme.of(context).surfaceContainerLowest,
                    padding: const EdgeInsets.symmetric(vertical: 20)
                        .copyWith(right: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(children: [
                          SizedBox(
                            child: Row(
                              children: [
                                Checkbox(
                                    value: data.isAllCartSelected,
                                    onChanged: (value) => sl<GetCartBloc>()
                                        .add(GetCartEvent.selectAllCarts())),
                                Text("All"),
                              ],
                            ),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text("Subtotal Rs. ${data.subTotal}"),
                            ],
                          ),
                          Gap(12),
                          FilledButton(
                              onPressed: data.selectedCarts.isEmpty
                                  ? null
                                  : () =>
                                      context.pushNamed(AppRouteName.checkout),
                              child: Text("Checkout"))
                        ]),
                      ],
                    ),
                  ),
            orElse: () => SizedBox());
      },
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
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: carts.length,
      itemBuilder: (context, index) {
        final cart = carts[index];
        return CartCard(cart: cart);
      },
    );
  }
}
