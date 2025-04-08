import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/common/widgets/app_loading.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import 'package:flutter_ecommerce/features/cart/models/cart.dart';
import 'package:flutter_ecommerce/features/cart/widgets/cart_card.dart';
import 'package:flutter_ecommerce/features/cart/widgets/empty_cart.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shopping Cart",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocBuilder<GetCartBloc, GetCartState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => AppLoading.center(),
            loaded: (data) => CustomScrollView(
              slivers: [
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: _BuildCarts(
                    carts: data.carts,
                  ),
                ),
              ],
            ),
            failure: (failure) => Center(
              child: Text(
                failure.toString(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(5),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: _BottomSheet(),
      ),
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
                ? EmptyCartWidget()
                : Container(
                    color: ColorScheme.of(context).surfaceContainerLow,
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
    return SliverList.builder(
      itemCount: carts.length,
      itemBuilder: (context, index) {
        final cart = carts[index];
        return CartCard(cart: cart);
      },
    );
  }
}
