import 'package:firebase_auth/firebase_auth.dart';

import 'package:another_notes/src/core/utils/result.dart';
import 'package:another_notes/src/feature/authentication/errors/auth_error.dart';
import 'package:another_notes/src/feature/authentication/models/auth_user.dart';
import 'package:another_notes/src/feature/authentication/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<Result<void>> emailLogIn({
    required String email,
    required String password,
  }) async {
    return _handleRequest(
      request: () => _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
      codeToError: EmailAuthError.fromCode,
    );
  }

  @override
  Future<Result<void>> emailSignUp({
    required String email,
    required String password,
  }) async {
    return _handleRequest(
      request: () => _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
      codeToError: EmailAuthError.fromCode,
    );
  }

  @override
  Future<Result<void>> logOut() async {
    return _handleRequest(
      request: () => _firebaseAuth.signOut(),
      codeToError: EmailAuthError.fromCode,
    );
  }

  @override
  Stream<AuthUser?> get authUser {
    return _firebaseAuth.authStateChanges().map((User? firebaseUser) {
      if (firebaseUser == null) {
        return null;
      }
      return AuthUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        displayName: firebaseUser.displayName,
        photoUrl: firebaseUser.photoURL,
        emailVerified: firebaseUser.emailVerified,
      );
    });
  }

  @override
  Future<Result<void>> resetPassword({required String email}) async {
    return _handleRequest(
      request: () => _firebaseAuth.sendPasswordResetEmail(email: email),
      codeToError: EmailAuthError.fromCode,
    );
  }

  Future<Result<T>> _handleRequest<T>({
    required Future<T> Function() request,
    required AuthError Function(String code) codeToError,
  }) async {
    try {
      final T result = await request();
      return Result<T>.ok(result);
    } on FirebaseAuthException catch (e) {
      return Result<T>.error(codeToError(e.code));
    } catch (e) {
      return Result<T>.error(
          EmailAuthError('An unknown exception occurred: ${e.toString()}'));
    }
  }
}
