import 'package:another_notes/src/feature/authentication/ui/login/login_view.dart';
import 'package:flutter/material.dart';

import 'package:another_notes/src/feature/authentication/models/auth_user.dart';
import 'package:another_notes/src/feature/authentication/repositories/auth_repository.dart';
import 'package:another_notes/src/feature/home/ui/home_view.dart';
import 'package:another_notes/src/feature/initialization/widgets/dependencies_scope.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final IAuthRepository _authRepository =
      DependenciesScope.of(context).authRepository;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthUser?>(
      stream: _authRepository.authUser,
      builder: (BuildContext context, AsyncSnapshot<AuthUser?> snapshot) {
        debugPrint('AuthGate - Connection state: ${snapshot.connectionState}');
        debugPrint('AuthGate - Has data: ${snapshot.hasData}');
        debugPrint('AuthGate - Data: ${snapshot.data}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final AuthUser? user = snapshot.data;
        if (user != null) {
          return const HomeView();
        } else {
          return const LoginView();
        }
      },
    );
  }
}
