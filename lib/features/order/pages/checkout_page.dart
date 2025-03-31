import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/common/widgets/app_loading.dart';
import 'package:flutter_ecommerce/common/widgets/custom_cached_network_image.dart';
import 'package:flutter_ecommerce/features/cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import 'package:flutter_ecommerce/features/cart/models/cart.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: BlocBuilder<GetCartBloc, GetCartState>(
        builder: (context, state) {
          return state.when(
              initial: () => SizedBox(),
              loading: () => AppLoading.center(),
              loaded: (data) => _BuildCheckOutCarts(
                    selectedCarts: data.selectedCarts,
                  ),
              failure: (failure) => Center(
                    child: Text(failure.toString()),
                  ));
        },
      ),
      bottomNavigationBar: _BottomNavBar(),
    );
  }
}

class _BuildCheckOutCarts extends StatelessWidget {
  const _BuildCheckOutCarts({required this.selectedCarts});
  final List<Cart> selectedCarts;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: selectedCarts.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final cart = selectedCarts[index];
          return Row(children: [
            SizedBox(
              height: 150,
              width: 100,
              child: AppCachedNetworkImage(
                imageUrl: cart.product.images.firstOrNull?.url,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      cart.product.name,
                      style: Theme.of(context).textTheme.labelLarge,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rs. ${cart.product.price}",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "x${cart.quantity}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ]);
        });
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCartBloc, GetCartState>(
      builder: (context, state) {
        return state.maybeWhen(
            loaded: (data) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [Text("Total"), Text("Rs. ${data.subTotal}")],
                      ),
                      Spacer(),
                      FilledButton(
                        onPressed: () {},
                        child: Text("Checkout"),
                      )
                    ],
                  ),
                ),
            orElse: () => SizedBox());
      },
    );
  }
}
