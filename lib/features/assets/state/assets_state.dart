import 'package:tractian_test/features/assets/models/asset_model.dart';
import 'package:tractian_test/features/assets/models/location_model.dart';
import 'package:tractian_test/features/assets/models/tree_node.dart';

abstract class AssetsState {}

class InitialAssetsState extends AssetsState {}

class LoadingAssetsState extends AssetsState {}

class LoadedAssetsState extends AssetsState {
  final List<AssetModel> assets;
  final List<LocationModel> locations;
  final bool onlyEletric;
  final bool onlyCritic;
  final String? searchKey;

  LoadedAssetsState({
    required this.assets,
    required this.locations,
    this.onlyEletric = false,
    this.onlyCritic = false,
    this.searchKey,
  });

  bool get isFiltered => onlyCritic || onlyEletric || searchKey != null;

  TreeNode get getTreeNode {
    final firstNode = TreeNode(
      id: "0",
      name: "root",
      data: null,
      nodes: {},
    );

    final subLocations = [];

    for (LocationModel location in locations) {
      if (location.parentId == null) {
        firstNode.addNode(
          TreeNode.fromLocation(location),
        );
      } else {
        subLocations.add(location);
      }
    }

    for (LocationModel subLocation in subLocations) {
      firstNode.addNodeInParent(
        TreeNode.fromLocation(subLocation),
        subLocation.parentId!,
      );
    }

    for (AssetModel asset in assets) {
      final node = TreeNode.fromAsset(asset);

      if (asset.isExternalComponent) {
        firstNode.addNode(node);
        continue;
      }

      if (asset.isAsset || asset.isLocationComponent) {
        firstNode.addNodeInParent(node, asset.locationId!);
        continue;
      }

      if (asset.isAssetComponent || asset.isSubAsset) {
        firstNode.addNodeInParent(node, asset.parentId!);

        continue;
      }
    }

    return firstNode;
  }
}

class EmptyAssetsState extends AssetsState {}
