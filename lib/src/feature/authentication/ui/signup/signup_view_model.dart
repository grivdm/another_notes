import 'package:flutter/widgets.dart';

import 'package:another_notes/src/core/utils/base_view_model.dart';
import 'package:another_notes/src/core/utils/result.dart';
import 'package:another_notes/src/feature/authentication/errors/auth_error.dart';
import 'package:another_notes/src/feature/authentication/repositories/auth_repository.dart';
import 'package:another_notes/src/feature/authentication/ui/signup/signup_view.dart';

class SignUpViewModel extends BaseViewModel<SignupView> {
  SignUpViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<bool> signUp({required String email, required String password}) async {
    setError(null);

    final Result<void> result = await _authRepository.emailSignUp(
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

  Future<void> submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      final String email = emailTextController.text;
      final String password = passwordTextController.text;
      await signUp(email: email, password: password);
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
