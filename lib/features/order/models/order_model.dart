// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_ecommerce/features/product/models/product.dart';
import 'package:flutter_ecommerce/features/cart/models/cart.dart';

abstract class BaseOrderModel {
  final double totalAmount;
  final String shippingAddressId;

  const BaseOrderModel({
    required this.totalAmount,
    required this.shippingAddressId,
  });
}

class BuyNowOrderModel extends BaseOrderModel {
  final Product product;
  final int quantity;

  BuyNowOrderModel({
    required this.product,
    required this.quantity,
    required super.totalAmount,
    required super.shippingAddressId,
  });
}

class CartOrderModel extends BaseOrderModel {
  final List<Cart> carts;

  CartOrderModel({
    required this.carts,
    required super.totalAmount,
    required super.shippingAddressId,
  });
}
