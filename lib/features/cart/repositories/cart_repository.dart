import 'package:flutter_ecommerce/common/utils/typedef.dart';
import 'package:flutter_ecommerce/core/exception.dart';
import 'package:flutter_ecommerce/core/repositories/user_local_data_repository.dart';
import 'package:flutter_ecommerce/features/cart/models/cart_form.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CartRepository {
  FutureEither<String> addCart(CartForm cart);
  FutureEither<String> updateCart({required String id, required CartForm cart});
}

class CartRepositoryI implements CartRepository {
  final UserLocalDataRepository _userRepo;
  final SupabaseClient _client;

  CartRepositoryI(
      {required UserLocalDataRepository userRepo,
      required SupabaseClient client})
      : _userRepo = userRepo,
        _client = client;
  @override
  FutureEither<String> addCart(CartForm cart) async {
    return await handleApplicationException(() async {
      final userId = await _getUserId();
      final existingCartItem = await _client
          .from('carts')
          .select()
          .eq('user_id', userId)
          .eq('product_id', cart.productId)
          .maybeSingle();

      if (existingCartItem != null) {
        await _client.from('carts').update({
          'quantity': existingCartItem['quantity'] + cart.quantity,
        }).eq('id', existingCartItem['id']);
      } else {
        await _client
            .from('carts')
            .insert({...cart.toJson(), 'user_id': userId});
      }
      return "Success! Cart added.";
    });
  }

  @override
  FutureEither<String> updateCart(
      {required String id, required CartForm cart}) async {
    return await handleApplicationException(() async {
      await _client.from("carts").update(cart.toJson()).eq('id', id);
      return "Success! Cart update.";
    });
  }

  Future<String> _getUserId() async {
    final failureOrUser = await _userRepo.getData();
    return failureOrUser.fold((failure) => throw failure, (user) => user.id);
  }
}
