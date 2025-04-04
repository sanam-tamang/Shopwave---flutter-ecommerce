import 'package:flutter/material.dart';

class OrderManagementPage extends StatelessWidget {
  const OrderManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Management"),
      ),
      body: Center(
        child: Text("Order Management Page"),
      ),
    );
  }
}
