import 'package:flutter/material.dart';
import 'package:tractian_test/features/assets/models/asset_model.dart';
import 'package:tractian_test/features/assets/models/location_model.dart';
import 'package:tractian_test/features/assets/repository/assets_repository.dart';
import 'package:tractian_test/features/assets/state/assets_state.dart';

class AssetsController extends ValueNotifier<AssetsState> {
  AssetsController({required this.repository}) : super(InitialAssetsState());

  final AssetsRepository repository;
  void getLocationsAndAssets(String companyId) async {
    value = LoadingAssetsState();

    final results = await Future.wait([
      repository.getLocations(companyId),
      repository.getAssets(companyId),
    ]);

    (results.last as List<AssetModel>).sort(AssetModel.compare);

    value = LoadedAssetsState(
      locations: results.first as List<LocationModel>,
      assets: results.last as List<AssetModel>,
    );
  }

  void toggleEnergyFilter() {
    final previousState = (value as LoadedAssetsState);
    value = LoadedAssetsState(
      assets: previousState.assets,
      locations: previousState.locations,
      onlyCritic: false,
      onlyEletric: !previousState.onlyEletric,
    );
  }

  void toggleCriticFilter() {
    final previousState = (value as LoadedAssetsState);
    value = LoadedAssetsState(
      assets: previousState.assets,
      locations: previousState.locations,
      onlyCritic: !previousState.onlyCritic,
      onlyEletric: false,
    );
  }

  void search(String searchKey) {
    final previousState = (value as LoadedAssetsState);
    value = LoadedAssetsState(
      assets: previousState.assets,
      locations: previousState.locations,
      onlyCritic: false,
      onlyEletric: false,
      searchKey: searchKey,
    );
  }
}
