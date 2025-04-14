import 'package:flutter/material.dart';

import 'package:another_notes/src/feature/initialization/model/dependencies_container.dart';

class DependenciesScope extends InheritedWidget {
  const DependenciesScope({
    super.key,
    required super.child,
    required this.dependencies,
  });

  final DependenciesContainer dependencies;

  static DependenciesContainer of(BuildContext context) {
    final DependenciesScope? scope =
        context.getInheritedWidgetOfExactType<DependenciesScope>();
    if (scope == null) {
      throw FlutterError('DependenciesScope not found in context. '
          'Make sure to wrap your widget with DependenciesScope.');
    }
    return scope.dependencies;
  }

  @override
  bool updateShouldNotify(DependenciesScope oldWidget) =>
      !identical(dependencies, oldWidget);
}
