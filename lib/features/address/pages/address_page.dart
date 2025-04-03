import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_ecommerce/common/widgets/app_loading.dart';
import 'package:flutter_ecommerce/features/address/blocs/get_address_bloc/get_address_bloc.dart';
import 'package:flutter_ecommerce/features/address/widgets/shipping_address_list.dart';
import 'package:flutter_ecommerce/routes.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({
    super.key,
    this.isSelectableAddress,
  });
  final bool? isSelectableAddress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address"),
      ),
      body: BlocBuilder<GetAddressBloc, GetAddressState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => AppLoading.center(),
            loaded: (addresses) => ShippingAddressList(
              addresses: addresses,
              isSelectAble: isSelectableAddress ?? false,
            ),
            failure: (failure) => Center(
              child: Text(failure.toString()),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(AppRouteName.addressForm),
        label: const Text("Add New Address"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
