// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/address/models/address_model.dart';

class ShippingAddressCard extends StatelessWidget {
  const ShippingAddressCard({
    super.key,
    required this.address,
  });
  final Address address;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorScheme.of(context).surfaceContainerLow,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shiping address",
                    style: TextTheme.of(context).titleMedium,
                  ),
                  RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          style: TextTheme.of(context).bodyLarge,
                          children: [
                            TextSpan(
                              text: address.address,
                            ),
                            TextSpan(
                              text: " ${address.state} ",
                            ),
                            TextSpan(
                              text: "${address.city} ",
                            ),
                            TextSpan(
                              text: address.zipCode ?? "",
                            ),
                          ])),
                ],
              ),
            ),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.arrow_forward_ios_rounded))
          ],
        ),
      ),
    );
  }
}
