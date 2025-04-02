import 'package:flutter_ecommerce/common/utils/typedef.dart';
import 'package:flutter_ecommerce/core/exception.dart';
import 'package:flutter_ecommerce/core/repositories/user_local_data_repository.dart';
import 'package:flutter_ecommerce/features/order/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

abstract interface class OrderRepository {
  FutureEither<String> createCartOrder(CartOrderModel order);
  FutureEither<String> createBuyNowOrder(BuyNowOrderModel order);
}

class OrderRepositoryI implements OrderRepository {
  final UserLocalDataRepository _userRepo;
  final SupabaseClient _client;
  OrderRepositoryI(
      {required UserLocalDataRepository userRepo,
      required SupabaseClient client})
      : _userRepo = userRepo,
        _client = client;
  @override
  FutureEither<String> createBuyNowOrder(BuyNowOrderModel order) async {
    return await handleApplicationException(() async {
      final orderId = Uuid().v4();
      await _createOrder(orderId, order);
      await _createBuyNowOrderItem(orderId, order);

      return orderId;
    });
  }

  @override
  FutureEither<String> createCartOrder(CartOrderModel order) async {
    return await handleApplicationException(() async {
      final orderId = Uuid().v4();
      await _createOrder(orderId, order);
      await _createCartOrderItems(orderId, order);

      return orderId;
    });
  }

  Future<String> _getUserId() async {
    final failureOrUser = await _userRepo.getData();
    return failureOrUser.fold((failure) => throw failure, (user) => user.id);
  }

  FutureEither<void> _createOrder(String orderId, BaseOrderModel order) async {
    return await handleApplicationException(() async {
      final userId = await _getUserId();
      await _client.from("orders").insert({
        "id": orderId,
        "user_id": userId,
        "total_price": order.totalAmount,
        "shipping_address": order.shippingAddressId,
      });

      return;
    });
  }

  Future<void> _createCartOrderItems(
      String orderId, CartOrderModel order) async {
    List<Map<String, dynamic>> orderItemMap = order.carts
        .map((cart) => Map<String, dynamic>.from({
              "order_id": orderId,
              "product_id": cart.product.id,
              "quantity": cart.quantity,
              "price": cart.product.currentAmount,
            }))
        .toList();
    await _client.from("order_items").insert(orderItemMap);
    return;
  }

  Future<void> _createBuyNowOrderItem(
      String orderId, BuyNowOrderModel order) async {
    Map orderItemMap = Map.from({
      "order_id": orderId,
      "product_id": order.product.id,
      "quantity": order.quantity,
      "price": order.product.currentAmount,
    });

    await _client.from("order_items").insert(orderItemMap);
  }
}
