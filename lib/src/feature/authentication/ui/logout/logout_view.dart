import 'package:flutter/material.dart';

import 'package:another_notes/src/feature/authentication/repositories/auth_repository.dart';
import 'package:another_notes/src/feature/authentication/ui/logout/logout_view_model.dart';
import 'package:another_notes/src/feature/initialization/widgets/dependencies_scope.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  late LogoutViewModel _viewModel;
  late final AuthRepository _authRepository =
      DependenciesScope.of(context).authRepository;

  @override
  void initState() {
    super.initState();

    _viewModel = LogoutViewModel(authRepository: _authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _viewModel.logout();
      },
      child: const Text('Log Out'),
    );
  }
}
