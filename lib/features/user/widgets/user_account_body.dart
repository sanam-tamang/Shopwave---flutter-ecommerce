import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/theme/app_theme.dart';
import 'package:flutter_ecommerce/common/widgets/custom_cached_network_image.dart';
import 'package:flutter_ecommerce/features/user/model/user.dart';
import 'package:flutter_ecommerce/features/user/widgets/settings_list.dart';
import 'package:flutter_ecommerce/features/user/widgets/user_information_card.dart';
import 'package:gap/gap.dart';

class UserAccountBody extends StatelessWidget {
  const UserAccountBody({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      children: [
        const Gap(40),
        AppCachedNetworkImage.circular(
            radius: 50, imageUrl: user.profileImageUrl),
        const Gap(20),
        UserInformationCard(user: user),
        const Gap(24),
        SettingsList(),
        const Gap(40),
        Text(
          "Logout",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: secondarySeedColor,
              ),
        ),
        const Gap(40),
      ],
    );
  }
}
