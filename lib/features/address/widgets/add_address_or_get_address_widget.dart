import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/common/widgets/app_loading.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/address/blocs/current_shipping_address_bloc/current_shipping_address_bloc.dart';
import 'package:flutter_ecommerce/features/address/blocs/get_address_bloc/get_address_bloc.dart';
import 'package:flutter_ecommerce/features/address/widgets/add_shipping_address.dart';
import 'package:flutter_ecommerce/features/address/widgets/address_card.dart';

class AddAddressOrGetAddressWidget extends StatelessWidget {
  const AddAddressOrGetAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAddressBloc, GetAddressState>(
      listener: (context, state) {
        state.whenOrNull(
            loaded: (data) => sl<CurrentShippingAddressBloc>().add(
                CurrentShippingAddressEvent.initializeShippingAddress(
                    data.first)));
      },
      builder: (context, state) {
        return state.when(
          initial: () => SizedBox(),
          loading: () => AppLoading.center(),
          loaded: (addresses) => addresses.isEmpty
              ? AddShippingAddressButton()
              : ShippingAddressCard(),
          failure: (failure) => Text(failure.toString()),
        );
      },
    );
  }
}
