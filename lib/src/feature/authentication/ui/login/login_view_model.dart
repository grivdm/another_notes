import 'package:another_notes/src/feature/authentication/errors/auth_error.dart';
import 'package:another_notes/src/feature/authentication/ui/login/login_view.dart';
import 'package:flutter/widgets.dart';

import 'package:another_notes/src/core/utils/base_view_model.dart';
import 'package:another_notes/src/core/utils/result.dart';
import 'package:another_notes/src/feature/authentication/repositories/auth_repository.dart';

class LoginViewModel extends BaseViewModel<LoginView> {
  LoginViewModel({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  final IAuthRepository _authRepository;

  Future<bool> logIn({required String email, required String password}) async {
    setError(null);

    final Result<void> result = await _authRepository.emailLogIn(
      email: email,
      password: password,
    );

    switch (result) {
      case Ok<void>():
        return true;
      case Error<void>(:final Exception error):
        if (error is AuthError) {
          setError(error.message);
        } else {
          setError(error.toString());
        }
        return false;
    }
  }

  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController emailTextController = TextEditingController();
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  final FocusNode passwordFocusNode = FocusNode();
  final TextEditingController passwordTextController = TextEditingController();
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      final String email = emailTextController.text;
      final String password = passwordTextController.text;
      logIn(email: email, password: password);
    }
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    emailTextController.dispose();
    passwordFocusNode.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  void initState(BuildContext context) {}
}
