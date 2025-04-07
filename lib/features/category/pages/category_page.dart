import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/common/widgets/custom_cached_network_image.dart';
import 'package:flutter_ecommerce/features/cart/blocs/get_cart_bloc/get_cart_bloc.dart';
import 'package:flutter_ecommerce/features/category/blocs/get_category_bloc/get_category_bloc.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text("Categories"),
            ),
            BlocBuilder<GetCategoryBloc, GetCategoryState>(
              builder: (context, state) {
                return state.maybeWhen(
                    loaded: (data) => SliverList.builder(
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12)
                                .copyWith(bottom: 8),
                            child: Card(
                              color:
                                  ColorScheme.of(context).surfaceContainerLow,
                              elevation: 0,
                              child: ListTile(
                                minTileHeight: 70,
                                title: Text(data[index].name),
                                leading: SizedBox(
                                  width: 60,
                                  height: double.maxFinite,
                                  child: AppCachedNetworkImage(
                                      imageUrl: data[index].imageUrl),
                                ),
                              ),
                            ),
                          ),
                          itemCount: data.length,
                        ),
                    orElse: () => SizedBox());
              },
            )
          ],
        ),
      ),
    );
  }
}
