import 'package:get_it/get_it.dart';
import 'package:tractian_test/core/utils/feature.dart';
import 'package:tractian_test/features/home/repository/home_repository.dart';
import 'package:tractian_test/features/home/state/home_controller.dart';

class HomeFeature extends Feature {
  @override
  void registerDependencies() {
    GetIt.I.registerSingleton(HomeRepository(httpAdapter: GetIt.I()));

    GetIt.I.registerSingleton(HomeController(repository: GetIt.I()));
  }
}
