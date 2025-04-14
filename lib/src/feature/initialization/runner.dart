import 'dart:async';

import 'package:another_notes/src/feature/authentication/ui/login/login_view.dart';
import 'package:another_notes/src/feature/authentication/ui/signup/signup_view.dart';
import 'package:flutter/material.dart';

import 'package:another_notes/src/feature/authentication/widgets/auth_gate.dart';
import 'package:another_notes/src/feature/initialization/composition_root.dart';
import 'package:another_notes/src/feature/initialization/model/dependencies_container.dart';
import 'package:another_notes/src/feature/initialization/widgets/dependencies_scope.dart';

class Runner {
  const Runner._();

  static Future<void> startup() async {
    await runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      Future<void> launchApplication() async {
        final DependenciesContainer compositionResult =
            await CompositionRoot().compose();
        runApp(
          DependenciesScope(
            dependencies: compositionResult,
            child: MaterialApp(
              routes: <String, WidgetBuilder>{
                '/': (BuildContext context) => const AuthGate(),
                SignupView.routePath: (BuildContext context) =>
                    const SignupView(),
                LoginView.routePath: (BuildContext context) =>
                    const LoginView(),
              },
              initialRoute: '/',
            ),
          ),
        );
      }

      launchApplication();
    }, (Object error, StackTrace stackTrace) {
      debugPrint('Error: $error\nStackTrace: $stackTrace');
    });
  }
}
