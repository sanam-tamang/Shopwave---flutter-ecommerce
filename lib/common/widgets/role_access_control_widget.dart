// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ecommerce/core/blocs/user_local_data/user_local_data_bloc.dart';

class RoleBasedWidget extends StatelessWidget {
  const RoleBasedWidget({
    super.key,
    this.generalUser,
    required this.adminUser,
  });
  final Widget? generalUser;
  final Widget adminUser;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLocalDataBloc, UserLocalDataState>(
      builder: (context, state) {
        return state.maybeWhen(
            orElse: () => generalUser ?? SizedBox.shrink(),
            loaded: (user) => user.role == "admin"
                ? adminUser
                : generalUser ?? SizedBox.shrink());
      },
    );
  }
}
