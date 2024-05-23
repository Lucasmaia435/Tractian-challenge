import 'package:tractian_test/core/http_adapter.dart';
import 'package:tractian_test/features/assets/models/asset_model.dart';
import 'package:tractian_test/features/assets/models/location_model.dart';

class AssetsRepository {
  final HttpAdapter httpAdapter;

  AssetsRepository({required this.httpAdapter});

  Future<List<LocationModel>> getLocations(String companyId) async {
    final locationsData =
        await httpAdapter.get("/companies/$companyId/locations");

    final List<LocationModel> locations = List.from(
      locationsData.map((json) => LocationModel.fromJson(json)),
    );

    return locations;
  }

  Future<List<AssetModel>> getAssets(String companyId) async {
    final assetsData = await httpAdapter.get("/companies/$companyId/assets");

    final List<AssetModel> assets = List.from(
      assetsData.map((json) => AssetModel.fromJson(json)),
    );

    return assets;
  }
}
