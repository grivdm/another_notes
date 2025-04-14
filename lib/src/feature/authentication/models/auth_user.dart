import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

@freezed
sealed class AuthUser with _$AuthUser {
  factory AuthUser({
    required String uid,
    String? email,
    String? displayName,
    String? photoUrl,
    @Default(false) bool emailVerified,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);

  static AuthUser empty = AuthUser(uid: '');
}
