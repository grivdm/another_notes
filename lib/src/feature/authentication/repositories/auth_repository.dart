import 'package:another_notes/src/core/utils/result.dart';
import 'package:another_notes/src/feature/authentication/models/auth_user.dart';

abstract interface class IAuthRepository {
  Future<Result<void>> emailLogIn({
    required String email,
    required String password,
  });
  Future<Result<void>> emailSignUp({
    required String email,
    required String password,
  });
  Future<Result<void>> logOut();

  Stream<AuthUser?> get authUser;

  Future<Result<void>> resetPassword({required String email});
}
