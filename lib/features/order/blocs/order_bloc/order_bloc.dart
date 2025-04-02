import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/core/state/base_state.dart';
import 'package:flutter_ecommerce/features/order/models/order_model.dart';
import 'package:flutter_ecommerce/features/order/repositories/order_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepo;
  OrderBloc({required OrderRepository repo})
      : _orderRepo = repo,
        super(OrderState.initial()) {
    on<OrderEvent>((event, emit) async {
      await event.when(
        placeCartOrder: (order) => _placeCartOrder(order, emit),
        buyNowOrder: (order) => _buyNowOrder(order, emit),
      );
    });
  }

  Future<void> _buyNowOrder(
      BuyNowOrderModel order, Emitter<OrderState> emit) async {
    emit(OrderState.loading());
    final failureOrOrder = await _orderRepo.createBuyNowOrder(order);
    failureOrOrder.fold(
      (failure) => emit(OrderState.failure(failure)),
      (order) => emit(OrderState.loaded(order)),
    );
  }

  Future<void> _placeCartOrder(
      CartOrderModel order, Emitter<OrderState> emit) async {
    emit(OrderState.loading());
    final failureOrOrder = await _orderRepo.createCartOrder(order);
    failureOrOrder.fold(
      (failure) => emit(OrderState.failure(failure)),
      (order) => emit(OrderState.loaded(order)),
    );
  }
}
