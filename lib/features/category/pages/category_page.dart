import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/common/widgets/custom_cached_network_image.dart';
import 'package:flutter_ecommerce/features/category/blocs/get_category_bloc/get_category_bloc.dart';
import 'package:flutter_ecommerce/features/category/models/category.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:go_router/go_router.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ).copyWith(bottom: 12, top: 4),
                child: Text(
                  "Shop by Categories",
                  style: TextTheme.of(context)
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            BlocBuilder<GetCategoryBloc, GetCategoryState>(
              builder: (context, state) {
                return state.maybeWhen(
                    loaded: (categories) => SliverList.builder(
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12)
                                .copyWith(bottom: 8),
                            child: Card(
                              color:
                                  ColorScheme.of(context).surfaceContainerLow,
                              elevation: 0,
                              child: ListTile(
                                onTap: () => _navigateToProductByCategoryPage(
                                    context, categories, index),
                                minTileHeight: 70,
                                title: Text(categories[index].name),
                                leading: SizedBox(
                                  width: 60,
                                  height: double.maxFinite,
                                  child: AppCachedNetworkImage(
                                      imageUrl: categories[index].imageUrl),
                                ),
                              ),
                            ),
                          ),
                          itemCount: categories.length,
                        ),
                    orElse: () => SizedBox());
              },
            )
          ],
        ),
      ),
    );
  }

  Future<Object?> _navigateToProductByCategoryPage(
      BuildContext context, List<Category> categories, int index) {
    return context.pushNamed(AppRouteName.productByCategory,
        queryParameters: {"name": categories[index].name},
        pathParameters: {"id": categories[index].id.toString()});
  }
}
