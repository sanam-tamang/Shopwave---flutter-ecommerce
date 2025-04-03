import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/custom_list_tile_card.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:go_router/go_router.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        CustomListTileCard(
            title: "Address",
            onTap: () => context.pushNamed(AppRouteName.addressForm)),
        CustomListTileCard(
          title: "Orders",
          onTap: () {},
        ),
        CustomListTileCard(
          title: "Payment",
          onTap: () {},
        ),
        CustomListTileCard(
          title: "Help",
          onTap: () {},
        ),
        CustomListTileCard(
          title: "Support",
          onTap: () {},
        ),
      ],
    );
  }
}
