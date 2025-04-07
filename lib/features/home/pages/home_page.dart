// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/features/category/widgets/category_list.dart';
import 'package:flutter_ecommerce/features/product/widgets/product_grid.dart';
import 'package:flutter_ecommerce/common/widgets/app_loading.dart';
import 'package:flutter_ecommerce/features/category/blocs/get_category_bloc/get_category_bloc.dart';
import 'package:flutter_ecommerce/features/product/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:flutter_ecommerce/features/search/widgets/app_search_box.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(
                  "Ecommerce",
                ),
              ),
              SliverAppBar(
                pinned: true,
                flexibleSpace: AppSearchBoxUI(),
              ),
            ];
          },
          body: _buildBody(),
        ),
      ),
    );
  }

  SliverPadding _buildProductList() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      sliver: BlocBuilder<GetProductBloc, GetProductState>(
        builder: (context, state) {
          return state.maybeWhen(
              loaded: (products) => BuildProductGrid(
                    products: products,
                  ),
              orElse: () => SliverToBoxAdapter());
        },
      ),
    );
  }

  BlocBuilder<GetCategoryBloc, GetCategoryState> _buildBody() {
    return BlocBuilder<GetCategoryBloc, GetCategoryState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => SizedBox(),
          loading: () => AppLoading.center(),
          loaded: (categories) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: ProductCategories(
                    categories: categories,
                  ),
                ),
                _buildProductHeader(context),
                _buildProductList(),
              ],
            );
          },
          failure: (failure) => Text(failure.toString()),
        );
      },
    );
  }

  SliverToBoxAdapter _buildProductHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          "Products",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
