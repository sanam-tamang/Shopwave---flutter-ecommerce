import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/core/blocs/user_local_data/user_local_data_bloc.dart';
import 'package:flutter_ecommerce/common/utils/extension.dart';
import 'package:flutter_ecommerce/common/utils/toast_msg.dart';
import 'package:flutter_ecommerce/common/widgets/app_loading.dart';
import 'package:flutter_ecommerce/common/widgets/role_access_control_widget.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/user/blocs/user_bloc/user_bloc.dart';

class UserAccountPage extends StatelessWidget {
  const UserAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RoleBasedWidget(
          adminUser: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      )),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          state.whenOrNull(
            failure: (failure) => AppToast.error(context, failure.toString()),
            loaded: (data) =>
                sl<UserLocalDataBloc>().add(UserLocalDataEvent.get()),
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
              orElse: () => SizedBox.shrink(),
              loading: () => AppLoading.center(),
              loaded: (user) => CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 250,
                        snap: true,
                        floating: true,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(
                            user.username.addUserName,
                            style: TextTheme.of(context).labelLarge,
                          ),
                          background: Container(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ));
        },
      ),
    );
  }
}
