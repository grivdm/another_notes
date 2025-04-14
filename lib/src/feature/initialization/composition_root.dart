import 'package:another_notes/src/feature/initialization/model/dependencies_container.dart';

class CompositionRoot {
  Future<DependenciesContainer> compose() async {
    final DependenciesContainer dependencies =
        await const DependenciesFactory().create();
    return dependencies;
  }
}
