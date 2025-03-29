// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/common/utils/loading_dialog.dart';
import 'package:flutter_ecommerce/common/utils/toast_msg.dart';

import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/cart/blocs/bloc/cart_bloc.dart';
import 'package:flutter_ecommerce/features/cart/models/cart_form.dart';
import 'package:flutter_ecommerce/features/product/widgets/item_quantity_controller.dart';
import 'package:gap/gap.dart';

import 'package:flutter_ecommerce/common/widgets/app_read_more.dart';
import 'package:flutter_ecommerce/common/widgets/custom_cached_network_image.dart';
import 'package:flutter_ecommerce/features/product/models/product.dart';
import 'package:flutter_ecommerce/features/product/widgets/product_price.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    this.product,
  });
  final Product? product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  double currentImageIndex = 0.0;
  Product? product;
  int _quantity = 1;
  @override
  void initState() {
    product = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return product != null
        ? Scaffold(
            appBar: AppBar(
              title: Text(product!.name),
            ),
            bottomNavigationBar: _bottomSheet(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageCarousel(),
                  _buildProductDetail(),
                ],
              ),
            ),
          )
        : Material(
            child: Center(child: Text("No Product found ")),
          );
  }

  Widget _bottomSheet() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
            .copyWith(top: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ItemQuantityController(
              getQuantity: (quantity) {
                _quantity = quantity;
              },
            ),
            Gap(12),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text("Buy now"),
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 3,
                  child: BlocListener<CartBloc, CartState>(
                    listener: (context, state) {
                      state.whenOrNull(
                          loading: () =>
                              AppProgressIndicator.showWithContainer(context),
                          loaded: (data) {
                            AppProgressIndicator.hide(context);
                            AppToast.success(context, data);
                          },
                          failure: (failure) =>
                              AppToast.error(context, failure.toString()));
                    },
                    child: FilledButton(
                      onPressed: _onAddToCart,
                      child: Text("Add to cart"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildProductDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product!.name,
            style: TextTheme.of(context)
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Gap(8),
          ProductPrice(product: product!),
          Gap(8),
          AppReadMore(
            product!.description,
            trimLines: 12,
            style: TextTheme.of(context)
                .labelLarge
                ?.copyWith(color: Colors.black54),
          ),
          Gap(8),
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Positioned.fill(
            child: CarouselSlider.builder(
              itemCount: product!.images.length,
              itemBuilder: (context, index, realIndex) {
                return SizedBox.expand(
                  child: AppCachedNetworkImage(
                    imageUrl: product!.images[index].url,
                    fit: BoxFit.cover,
                  ),
                );
              },
              options: CarouselOptions(
                enlargeCenterPage: true,
                reverse: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentImageIndex = index.toDouble();
                  });
                },
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: _buildPageIndicator(
                  currentImageIndex, product!.images.length))
        ],
      ),
    );
  }

  Widget _buildPageIndicator(double currentIndex, int totalLength) {
    return DotsIndicator(
      dotsCount: totalLength,
      position: currentIndex,
      decorator: DotsDecorator(
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  void _onAddToCart() {
    final cart = CartForm(productId: product!.id, quantity: _quantity);
    sl<CartBloc>().add(CartEvent.add(cart));
  }
}
