import 'package:flutter/material.dart';
import 'package:tractian_test/core/colors.dart';
import 'package:tractian_test/features/assets/models/asset_model.dart';
import 'package:tractian_test/features/assets/models/tree_node.dart';

class AssetsNodeWidget extends StatefulWidget {
  const AssetsNodeWidget({super.key, required this.node});

  final TreeNode node;

  @override
  State<AssetsNodeWidget> createState() => _AssetsNodeWidgetState();
}

class _AssetsNodeWidgetState extends State<AssetsNodeWidget> {
  bool isExpanded = false;

  String get getImageAsset {
    if (widget.node.data is AssetModel) {
      if (widget.node.data.isComponent) {
        return "assets/component.png";
      } else {
        return "assets/asset.png";
      }
    }

    return "assets/location.png";
  }

  Widget get getTrailing {
    final data = widget.node.data;
    if (data is AssetModel && data.isComponent) {
      switch (data.status) {
        case ComponentStatus.operating:
          return Icon(Icons.bolt, color: TractianColors.operatingStatusColor);
        case ComponentStatus.alert:
          return Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: TractianColors.alertStatusColor,
              shape: BoxShape.circle,
            ),
          );
        case null:
          break;
      }
    }

    return const SizedBox.square(
      dimension: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasChildren = widget.node.nodes.isNotEmpty;

    return ExpansionTile(
      title: Row(
        children: [
          hasChildren
              ? Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  size: 22,
                )
              : const SizedBox(
                  height: 22,
                  width: 22,
                ),
          Image.asset(
            getImageAsset,
            height: 22,
            width: 22,
          ),
          Text(
            widget.node.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: getTrailing,
          ),
        ],
      ),
      // enabled: widget.node.nodes.isNotEmpty,
      shape: const RoundedRectangleBorder(),
      tilePadding: const EdgeInsets.only(right: 0),
      minTileHeight: 0,
      controlAffinity: ListTileControlAffinity.trailing,
      trailing: const SizedBox.shrink(),
      dense: false,
      onExpansionChanged: (value) => setState(() => isExpanded = value),
      childrenPadding: const EdgeInsets.only(left: 14),
      children: widget.node.nodes.map((node) => node.toWidget()).toList(),
    );
  }
}
