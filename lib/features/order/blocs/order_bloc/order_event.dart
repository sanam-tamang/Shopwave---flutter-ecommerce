part of 'order_bloc.dart';

@freezed
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.placeCartOrder(CartOrderModel order) = _PlaceCartOrder;
  const factory OrderEvent.buyNowOrder(BuyNowOrderModel order) = _BuyNowOrder;
}