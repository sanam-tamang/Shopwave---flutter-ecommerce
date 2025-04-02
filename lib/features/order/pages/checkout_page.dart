// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/common/utils/loading_dialog.dart';
import 'package:flutter_ecommerce/common/utils/toast_msg.dart';

import 'package:flutter_ecommerce/common/widgets/app_loading.dart';
import 'package:flutter_ecommerce/common/widgets/custom_cached_network_image.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/address/blocs/get_address_bloc/get_address_bloc.dart';
import 'package:flutter_ecommerce/features/address/widgets/add_address_or_get_address_widget.dart';
import 'package:flutter_ecommerce/features/cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import 'package:flutter_ecommerce/features/cart/models/cart.dart';
import 'package:flutter_ecommerce/features/order/blocs/order_bloc/order_bloc.dart';
import 'package:flutter_ecommerce/features/order/models/order_model.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:go_router/go_router.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({
    super.key,
    this.order,
  });
  final BuyNowOrderModel? order;
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
        itemCount: selectedCarts.length + 1,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return AddAddressOrGetAddressWidget();
          }
          final cart = selectedCarts[index - 1];
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
                          cart.product.discountPrice == null
                              ? "Rs. ${cart.product.price}"
                              : "Rs. ${cart.product.discountPrice}",
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

class _BottomNavBar extends StatefulWidget {
  const _BottomNavBar();

  @override
  State<_BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<_BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCartBloc, GetCartState>(
      builder: (context, state) {
        return state.maybeWhen(
            loaded: (data) => Container(
                  color: ColorScheme.of(context).surfaceContainerLow,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Total",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text("Rs. ${data.subTotal}")
                          ],
                        ),
                        Spacer(),
                        BlocListener<OrderBloc, OrderState>(
                          listener: (context, state) {
                            state.whenOrNull(
                                loading: () =>
                                    AppProgressIndicator.show(context),
                                failure: (failure) {
                                  AppProgressIndicator.hide(context);
                                  AppToast.error(context, failure.toString());
                                },
                                loaded: (order) {
                                  AppProgressIndicator.hide(context);
                                  return context.pushReplacementNamed(
                                      AppRouteName.orderSuccessPage,
                                      extra: order);
                                });
                          },
                          child: BlocBuilder<GetAddressBloc, GetAddressState>(
                            builder: (context, state) {
                              return FilledButton(
                                onPressed: () {
                                  final addressId = getAddressId(state);
                                  _placeCartOrder(CartOrderModel(
                                      carts: data.selectedCarts,
                                      totalAmount: data.subTotal,
                                      shippingAddressId: addressId!));
                                },
                                child: Text("Place order"),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            orElse: () => SizedBox());
      },
    );
  }

  void _placeCartOrder(CartOrderModel order) {
    sl<OrderBloc>().add(OrderEvent.placeCartOrder(order));
  }

  String? getAddressId(GetAddressState state) {
    final addressId = state.maybeWhen(
      loaded: (data) => data!.id,
      orElse: () {
        AppToast.error(context, "Please add address");
        context.pushNamed(AppRouteName.addressForm);
        return "";
      },
    );
    return addressId;
  }
}
