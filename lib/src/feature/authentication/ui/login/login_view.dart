import 'package:flutter/material.dart';

import 'package:another_notes/src/feature/authentication/repositories/auth_repository.dart';
import 'package:another_notes/src/feature/authentication/ui/login/login_view_model.dart';
import 'package:another_notes/src/feature/authentication/ui/signup/signup_view.dart';
import 'package:another_notes/src/feature/initialization/widgets/dependencies_scope.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const String routePath = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginViewModel _viewModel;
  late final AuthRepository _authRepository =
      DependenciesScope.of(context).authRepository;

  @override
  void initState() {
    super.initState();
    _viewModel = LoginViewModel(authRepository: _authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _viewModel.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _viewModel.emailTextController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: _viewModel.emailValidator,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _viewModel.passwordTextController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: _viewModel.passwordValidator,
              ),
              const SizedBox(height: 24),
              if (_viewModel.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    _viewModel.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ElevatedButton(
                onPressed: _viewModel.submitForm,
                child: const Text('Log In'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(SignupView.routePath),
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
