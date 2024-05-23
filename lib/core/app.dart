import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_test/core/http_adapter.dart';
import 'package:tractian_test/features/assets/assets_feature.dart';
import 'package:tractian_test/features/home/home_feature.dart';

class App {
  static setUpFeatures() {
    HomeFeature().registerDependencies();
    AssetsFeature().registerDependencies();
  }

  static setUpAdapters() {
    GetIt.I.registerSingleton(
      HttpAdapterImpl(
        client: Dio(
          BaseOptions(baseUrl: "https://fake-api.tractian.com"),
        ),
      ),
    );
  }

  static setUp() {
    setUpAdapters();
    setUpFeatures();
  }
}
