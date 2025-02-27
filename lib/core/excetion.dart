import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce/common/utils/typedef.dart';
import 'package:flutter_ecommerce/core/failure/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

FutureEither<T> handleApplicationException<T>(
    Future<T> Function() operation) async {
  try {
    final result = await operation();
    return Right(result);
  } on AuthException catch (e) {
    return Left(FailureWithMsg("Authentication error: ${e.message}"));
  } on SocketException catch (e) {
    return Left(FailureWithMsg("Network error: ${e.message}"));
  } on TimeoutException {
    return Left(FailureWithMsg("Request timed out. Please try again."));
  } on FormatException {
    return Left(FailureWithMsg("Invalid format. Please check your input."));
  } catch (e) {
    return Left(FailureWithMsg("Unexpected error: ${e.toString()}"));
  }
}
