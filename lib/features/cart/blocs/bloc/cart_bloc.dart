import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/core/state/base_state.dart';
import 'package:flutter_ecommerce/features/cart/models/cart_form.dart';
import 'package:flutter_ecommerce/features/cart/repositories/cart_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _repo;
  CartBloc({required CartRepository repo})
      : _repo = repo,
        super(CartState.initial()) {
    on<CartEvent>((event, emit) async {
      await event.when(add: (cart) async {
        emit(CartState.loading());
        final failureOrSuccess = await _repo.addCart(cart);
        failureOrSuccess.fold((failure) => emit(CartState.failure(failure)),
            (success) => emit(CartState.loaded(success)));
      }, update: (id, cart) async {
        emit(CartState.loading());
        final failureOrSuccess = await _repo.updateCart(id: id, cart: cart);
        failureOrSuccess.fold((failure) => emit(CartState.failure(failure)),
            (success) => emit(CartState.loaded(success)));
      });
    });
  }
}
