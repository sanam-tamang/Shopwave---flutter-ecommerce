// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/common/widgets/custom_list_tile_card.dart';

import 'package:flutter_ecommerce/common/widgets/shipping_address_text.dart';
import 'package:flutter_ecommerce/features/address/blocs/current_shipping_address_bloc/current_shipping_address_bloc.dart';
import 'package:flutter_ecommerce/features/address/models/address_model.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:go_router/go_router.dart';

class ShippingAddressCard extends StatelessWidget {
  const ShippingAddressCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentShippingAddressBloc, CurrentShippingAddressState>(
      builder: (context, state) {
        return state.maybeWhen(
            loaded: (address) => _buildAddressCard(context, address),
            orElse: () => CustomListTileCard(
                  title: "Select shipping address",
                  onTap: () =>
                      context.pushNamed(AppRouteName.address, extra: true),
                ));
      },
    );
  }

  Card _buildAddressCard(BuildContext context, Address address) {
    return Card.filled(
      color: ColorScheme.of(context).surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(12),
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
                  ShippingAddressText(address: address),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  ///extra true means we addresses are selectable
                  context.pushNamed(AppRouteName.address, extra: true);
                },
                icon: Icon(Icons.arrow_forward_ios_rounded))
          ],
        ),
      ),
    );
  }
}
