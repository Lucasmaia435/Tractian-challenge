import 'package:get_it/get_it.dart';
import 'package:tractian_test/core/utils/feature.dart';
import 'package:tractian_test/features/assets/repository/assets_repository.dart';
import 'package:tractian_test/features/assets/state/assets_controller.dart';

class AssetsFeature extends Feature {
  @override
  void registerDependencies() {
    GetIt.I.registerSingleton(AssetsRepository(httpAdapter: GetIt.I()));

    GetIt.I.registerSingleton(AssetsController(repository: GetIt.I()));
  }
}
