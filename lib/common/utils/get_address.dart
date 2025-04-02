import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/address/blocs/get_address_bloc/get_address_bloc.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:go_router/go_router.dart';

String? getAddressId(BuildContext context, GetAddressState state) {
  final addressId = state.maybeWhen(
    loaded: (data) => data!.id,
    orElse: () {
      context.pushNamed(AppRouteName.addressForm);
      return "";
    },
  );
  return addressId;
}
