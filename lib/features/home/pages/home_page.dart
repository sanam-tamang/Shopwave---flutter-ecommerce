import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/common/widgets/app_loading.dart';
import 'package:flutter_ecommerce/common/widgets/custom_cached_network_image.dart';
import 'package:flutter_ecommerce/features/category/blocs/get_category_bloc/get_category_bloc.dart';
import 'package:flutter_ecommerce/features/product/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:flutter_ecommerce/features/product/widgets/product_card.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                // pinned: true,
                snap: true,

                floating: true,
                title: Text(
                  "Ecommerce",
                ),
              ),
              SliverAppBar(
                expandedHeight: 160,
                flexibleSpace: FlexibleSpaceBar(
                  background: CarouselView(
                      onTap: (index) {},
                      itemExtent: 270,
                      children: List.generate(10, (index) {
                        return LimitedBox(
                          maxHeight: 400,
                          child: Container(
                            color: Color.fromARGB(255, Random().nextInt(256),
                                120, Random().nextInt(256)),
                            child: Text("hello"),
                          ),
                        );
                      })),
                ),
              ),
            ];
          },
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildCategoryTabs(),
              ),
              BlocBuilder<GetProductBloc, GetProductState>(
                builder: (context, state) {
                  return state.maybeWhen(
                      loaded: (data) => SliverGrid.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ProductCard(product: data[index]);
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8),
                          ),
                      orElse: () => SliverToBoxAdapter());
                },
              ),
            ],
          )),
    );
  }

  BlocBuilder<GetCategoryBloc, GetCategoryState> _buildCategoryTabs() {
    return BlocBuilder<GetCategoryBloc, GetCategoryState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => SizedBox(),
          loading: () => AppLoading.center(),
          loaded: (categories) {
            return ColoredBox(
              color: ColorScheme.of(context).surfaceContainerLowest,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Categories",
                      style: TextTheme.of(context)
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Gap(12),
                    LimitedBox(
                      maxHeight: 140,
                      child: ListView.builder(
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 130,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: SizedBox(
                                  width: double.maxFinite,
                                  child: AppCachedNetworkImage(
                                    imageUrl: categories[index].imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                                Gap(8),
                                Center(
                                  child: Text(
                                    categories[index].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextTheme.of(context).labelMedium,
                                  ),
                                ),
                                Gap(4),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          failure: (failure) => Text(failure.toString()),
        );
      },
    );
  }
}
