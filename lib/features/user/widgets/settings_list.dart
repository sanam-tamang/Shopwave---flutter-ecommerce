import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/custom_list_tile_card.dart';
import 'package:flutter_ecommerce/common/widgets/role_access_control_widget.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:go_router/go_router.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoleBasedWidget(
          adminUser: CustomListTileCard(
            bottomMargin: 12,
            title: "Admin",
            onTap: () => context.pushNamed(AppRouteName.admin),
          ),
        ),
        RoleBasedWidget(
          vendorUser: CustomListTileCard(
            bottomMargin: 12,
            title: "Vendor",
            onTap: () => context.pushNamed(AppRouteName.vendor),
          ),
        ),
        CustomListTileCard(
            bottomMargin: 12,
            title: "Address",
            onTap: () => context.pushNamed(AppRouteName.address)),
        CustomListTileCard(
          bottomMargin: 12,
          title: "Orders",
          onTap: () => context.pushNamed(AppRouteName.orders),
        ),
        CustomListTileCard(
          bottomMargin: 12,
          title: "Payment",
          onTap: () {},
        ),
        CustomListTileCard(
          bottomMargin: 12,
          title: "Help",
          onTap: () {},
        ),
        CustomListTileCard(
          bottomMargin: 12,
          title: "Support",
          onTap: () {},
        ),
      ],
    );
  }
}
