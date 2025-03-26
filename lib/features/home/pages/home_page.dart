import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/common/widgets/app_loading.dart';
import 'package:flutter_ecommerce/features/category/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_ecommerce/features/category/blocs/get_category_bloc/get_category_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SliverAppBar(
                pinned: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.red,
                    child: BlocBuilder<GetCategoryBloc, GetCategoryState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => SizedBox(),
                          loading: () => AppLoading.center(),
                          loaded: (categories) {
                            return ListView.builder(
                              itemCount: categories.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(categories[index].name),
                                );
                              },
                            );
                          },
                          failure: (failure) => Text(failure.toString()),
                        );
                        return Text("hello");
                      },
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Text("hello")),
    );
  }
}
