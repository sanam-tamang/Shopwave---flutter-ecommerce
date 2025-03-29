import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/core/state/base_state.dart';
import 'package:flutter_ecommerce/features/cart/models/cart.dart';
import 'package:flutter_ecommerce/features/cart/repositories/cart_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_cart_event.dart';
part 'get_cart_state.dart';
part 'get_cart_bloc.freezed.dart';

class GetCartBloc extends Bloc<GetCartEvent, GetCartState> {
  final CartRepository _repo;
  GetCartBloc({required CartRepository repo})
      : _repo = repo,
        super(GetCartState.initial()) {
    on<GetCartEvent>((event, emit) async {
      await event.when(get: () async {
        emit(GetCartState.loading());
        final failureOrCarts = await _repo.getCart();
        failureOrCarts.fold(
          (failure) => emit(GetCartState.failure(failure)),
          (carts) => emit(GetCartState.loaded(carts)),
        );
      });
    });
  }
}
