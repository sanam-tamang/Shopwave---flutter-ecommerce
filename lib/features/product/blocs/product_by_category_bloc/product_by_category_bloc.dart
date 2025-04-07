import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/core/state/base_state.dart';
import 'package:flutter_ecommerce/features/product/models/product.dart';
import 'package:flutter_ecommerce/features/product/repositories/product_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_by_category_event.dart';
part 'product_by_category_state.dart';
part 'product_by_category_bloc.freezed.dart';

class ProductByCategoryBloc
    extends Bloc<ProductByCategoryEvent, ProductByCategoryState> {
  final ProductRepository _productRepository;
  ProductByCategoryBloc({required ProductRepository repo})
      : _productRepository = repo,
        super(ProductByCategoryState.initial()) {
    on<ProductByCategoryEvent>((event, emit) async {
      emit(ProductByCategoryState.loading());
      final failureOrProducts =
          await _productRepository.getProductsByCategory(event.categoryId);
      failureOrProducts.fold(
          (failure) => emit(ProductByCategoryState.failure(failure)),
          (products) => emit(ProductByCategoryState.loaded(products)));
    });
  }
}
