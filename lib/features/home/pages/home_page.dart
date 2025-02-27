import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/utils/extension.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:go_router/go_router.dart';

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
                      onTap: (index) {
                       
                      },
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
          body: Text("hello")),
    );
  }
}
