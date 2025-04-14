abstract class AuthError implements Exception {
  final String message;
  const AuthError(this.message);
}

class EmailAuthError extends AuthError {
  const EmailAuthError(super.message);

  factory EmailAuthError.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const EmailAuthError('Email is not valid or badly formatted.');
      case 'user-disabled':
        return const EmailAuthError(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const EmailAuthError(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const EmailAuthError('Incorrect password, please try again.');
      case 'email-already-in-use':
        return const EmailAuthError(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const EmailAuthError(
          'Operation is not allowed. Please contact support.',
        );
      case 'weak-password':
        return const EmailAuthError('Please enter a stronger password.');
      default:
        return const EmailAuthError('An unknown exception occurred.');
    }
  }
}

class LogOutError extends AuthError {
  const LogOutError([super.message = 'Failed to log out.']);
}
