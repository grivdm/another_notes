import 'package:flutter/widgets.dart';

import 'package:another_notes/src/core/utils/base_view_model.dart';
import 'package:another_notes/src/core/utils/result.dart';
import 'package:another_notes/src/feature/authentication/repositories/auth_repository.dart';
import 'package:another_notes/src/feature/authentication/ui/logout/logout_view.dart';

class LogoutViewModel extends BaseViewModel<LogoutButton> {
  LogoutViewModel({required AuthRepository authRepository})
      : _authReposiory = authRepository;

  final AuthRepository _authReposiory;
  @override
  void initState(BuildContext context) {}

  Future<bool> logout() async {
    final Result<void> result = await _authReposiory.logOut();

    switch (result) {
      case Ok<void>():
        return true;
      case Error<void>(:final Exception error):
        setError(error.toString());
        return false;
    }
  }
}
