import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_user_model.freezed.dart';
part 'local_user_model.g.dart';

@freezed
class LocalUserModel with _$LocalUserModel {
  const factory LocalUserModel({
    required String userId,
    required String role,
  }) = _LocalUserModel;

  factory LocalUserModel.fromJson(Map<String, dynamic> json) =>
      _$LocalUserModelFromJson(json);
}
