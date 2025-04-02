import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_ecommerce/common/utils/loading_dialog.dart';
import 'package:flutter_ecommerce/common/utils/toast_msg.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/order/blocs/order_bloc/order_bloc.dart';
import 'package:flutter_ecommerce/features/order/models/order_model.dart';
import 'package:flutter_ecommerce/routes.dart';

class CheckoutBottomBuyNowOrder extends StatelessWidget {
  const CheckoutBottomBuyNowOrder({
    super.key,
    required this.order,
  });
  final BuyNowOrderModel order;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorScheme.of(context).surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                Text("Rs. ${order.totalAmount}")
              ],
            ),
            Spacer(),
            BlocListener<OrderBloc, OrderState>(
              listener: (context, state) {
                state.whenOrNull(
                    loading: () => AppProgressIndicator.show(context),
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
              child: FilledButton(
                onPressed: _placeBuyNowOrder,
                child: Text("Place order"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _placeBuyNowOrder() {
    sl<OrderBloc>().add(OrderEvent.buyNowOrder(order));
  }
}
