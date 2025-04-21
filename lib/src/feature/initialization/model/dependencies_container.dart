import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:another_notes/src/feature/authentication/repositories/auth_repository.dart';
import 'package:another_notes/src/feature/authentication/repositories/auth_repository_impl.dart';

class DependenciesContainer {
  DependenciesContainer({
    required this.firebaseApp,
    required this.firebaseAuth,
    required this.authRepository,
  });
  final FirebaseApp firebaseApp;
  final FirebaseAuth firebaseAuth;
  final IAuthRepository authRepository;
}

class DependenciesFactory {
  const DependenciesFactory();

  Future<DependenciesContainer> create() async {
    final FirebaseApp firebaseApp = await Firebase.initializeApp();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final IAuthRepository authRepository =
        AuthRepositoryImpl(firebaseAuth: firebaseAuth);

    return DependenciesContainer(
      firebaseApp: firebaseApp,
      firebaseAuth: firebaseAuth,
      authRepository: authRepository,
    );
  }
}
