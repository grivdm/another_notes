import 'package:flutter/material.dart';

import 'package:another_notes/src/feature/authentication/models/auth_user.dart';
import 'package:another_notes/src/feature/authentication/repositories/auth_repository.dart';
import 'package:another_notes/src/feature/authentication/ui/signup/signup_view.dart';
import 'package:another_notes/src/feature/home/ui/home_view.dart';
import 'package:another_notes/src/feature/initialization/model/dependencies_container.dart';
import 'package:another_notes/src/feature/initialization/widgets/dependencies_scope.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final DependenciesContainer? dependencies = DependenciesScope.of(context);
    final AuthRepository? authRepository = dependencies?.authRepository;

    if (authRepository == null) {
      return const Scaffold(
        body: Center(
          child: Text('Failed to initialize dependencies'),
        ),
      );
    }

    return StreamBuilder<AuthUser?>(
      stream: authRepository.authUser,
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
          return const SignupView();
        }
      },
    );
  }
}
