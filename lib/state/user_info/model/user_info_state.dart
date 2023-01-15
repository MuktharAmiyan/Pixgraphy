import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_info_state.freezed.dart';

@freezed
class UserInfoState with _$UserInfoState {
  const factory UserInfoState.initial() = _Initial;
  const factory UserInfoState.faliure() = _Faliure;
  const factory UserInfoState.success() = _Success;
  const factory UserInfoState.loading() = _Loading;
}
