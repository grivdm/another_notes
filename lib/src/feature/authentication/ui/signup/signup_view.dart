import 'package:flutter/material.dart';

import 'package:another_notes/src/feature/authentication/repositories/auth_repository.dart';
import 'package:another_notes/src/feature/authentication/ui/login/login_view.dart';
import 'package:another_notes/src/feature/authentication/ui/signup/signup_view_model.dart';
import 'package:another_notes/src/feature/initialization/widgets/dependencies_scope.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});
  static const String routePath = '/signup';

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late SignUpViewModel _viewModel;
  late final AuthRepository _authRepository =
      DependenciesScope.of(context).authRepository;

  @override
  void initState() {
    super.initState();

    _viewModel = SignUpViewModel(authRepository: _authRepository);

    _viewModel.addListener(() {
      if (_viewModel.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_viewModel.errorMessage!)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(LoginView.routePath),
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
