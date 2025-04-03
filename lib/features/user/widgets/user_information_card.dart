import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/utils/extension.dart';
import 'package:flutter_ecommerce/features/user/model/user.dart';

class UserInformationCard extends StatelessWidget {
  const UserInformationCard({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: ColorScheme.of(context).surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  user.username.addUserName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            TextButton(onPressed: () {}, child: Text("Edit"))
          ],
        ),
      ),
    );
  }
}
