import 'package:flutter/material.dart';
import 'package:tractian_test/core/colors.dart';
import 'package:tractian_test/features/assets/state/utils/filter_tree.dart';
import 'package:tractian_test/features/assets/models/asset_model.dart';
import 'package:tractian_test/features/assets/models/tree_node.dart';
import 'package:tractian_test/features/assets/screen/widgets/assets_filter_header.dart';
import 'package:tractian_test/features/assets/state/assets_state.dart';

class AssetsTree extends StatelessWidget {
  const AssetsTree({super.key, required this.state});

  final LoadedAssetsState state;

  @override
  Widget build(BuildContext context) {
    TreeNode root = state.getTreeNode;

    if (state.isFiltered) {
      if (state.onlyCritic) {
        root = filterTree<AssetModel>(
              root,
              (node) => node.isCritic,
            ) ??
            TreeNode(id: "id", name: 'name', data: null, nodes: {});
      }

      if (state.onlyEletric) {
        root = filterTree<AssetModel>(
              root,
              (node) => node.isOperating,
            ) ??
            TreeNode(id: "id", name: 'name', data: null, nodes: {});
      }

      if (state.searchKey != null && state.searchKey!.isNotEmpty) {
        root = filterTree<AssetModel>(
              root,
              (node) => node.name.contains(state.searchKey!),
            ) ??
            TreeNode(id: "id", name: 'name', data: null, nodes: {});
      }
    }

    bool isEmpty() => root.nodes.isEmpty;

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          const AssetsFilterHeader(),
          Expanded(
            child: isEmpty()
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: TractianColors.iconLabelColor,
                        size: 48,
                      ),
                      Text(
                        "Nenhum dado encontrado!",
                        style: TextStyle(
                          color: TractianColors.iconLabelColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                : ListView(
                    children:
                        root.nodes.map((node) => node.toWidget()).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
