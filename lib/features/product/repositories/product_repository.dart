import 'package:flutter_ecommerce/common/utils/typedef.dart';
import 'package:flutter_ecommerce/core/exception.dart';
import 'package:flutter_ecommerce/core/repositories/image_uploader_repository.dart';
import 'package:flutter_ecommerce/features/product/models/product.dart';
import 'package:flutter_ecommerce/features/product/models/product_form.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

abstract interface class ProductRepository {
  FutureEither<List<Product>> getProducts();
  FutureEither<String> addProduct(ProductForm product);
  FutureEither<String> updateProduct(ProductForm product);
}

class ProductRepositoryI implements ProductRepository {
  final SupabaseClient _client;
  final ImageUploaderRepository _imageUploaderRepository;
  ProductRepositoryI(
      {required SupabaseClient client,
      required ImageUploaderRepository imageUploaderRepo})
      : _client = client,
        _imageUploaderRepository = imageUploaderRepo;

  @override
  FutureEither<String> addProduct(ProductForm product) async {
    return await handleApplicationException(() async {
      final productId = Uuid().v4();
      await _client.from('products').insert({
        'id': productId,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'category_id': product.categoryId,
        'quantity': product.quantity,
        'discount_price': product.discountPrice,
      });

      // Logger().d(response.toString());

      final imageUrls = await Future.wait(
        product.imageFiles.map((file) async {
          final imageUrl = await _imageUploaderRepository.uploadImage(
            imageFile: file,
          );
          return imageUrl;
        }),
      );

      await Future.wait(imageUrls.map((url) async {
        await _client.from('product_images').insert([
          {
            'image_url': url,
            'product_id': productId,
          }
        ]);
      }).toList());

      return "Product added successfully";
    });
  }

  @override
  FutureEither<String> updateProduct(ProductForm product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  FutureEither<List<Product>> getProducts() async {
    return await handleApplicationException(() async {
      final productsMap =
          await _client.from('products').select('*, images:product_images(*)');
      final products =
          List.from(productsMap).map((e) => Product.fromJson(e)).toList();
      return products;
    });
  }
}
