import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(
                  "Ecommerce",
                ),
              ),
              SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(
                  background: CarouselView.weighted(
                      flexWeights: [1, 7, 5],
                      children: List.generate(10, (index) {
                        return Container(
                          width: 200,
                          height: 500,
                          color: Color.fromARGB(255, Random().nextInt(256), 120,
                              Random().nextInt(256)),
                          child: Text("hello"),
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
