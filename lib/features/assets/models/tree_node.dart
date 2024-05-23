import 'package:tractian_test/features/assets/models/asset_model.dart';
import 'package:tractian_test/features/assets/models/location_model.dart';
import 'package:tractian_test/features/assets/screen/widgets/assets_node.dart';

class TreeNode<T> {
  final T? data;
  final String id;
  final String name;
  final Set<TreeNode> nodes;

  TreeNode({
    required this.id,
    required this.name,
    required this.data,
    required this.nodes,
  });

  void addNode(TreeNode node) {
    nodes.add(node);
  }

  factory TreeNode.fromLocation(LocationModel location) {
    return TreeNode<T>(
      id: location.id,
      name: location.name,
      data: location as T,
      nodes: {},
    );
  }

  factory TreeNode.fromAsset(AssetModel asset) {
    return TreeNode<T>(
      id: asset.id,
      name: asset.name,
      data: asset as T,
      nodes: {},
    );
  }

  TreeNode? addNodeInParent(TreeNode newNode, String parentId) {
    if (parentId == id) {
      this.addNode(newNode);

      return this;
    }

    for (TreeNode node in nodes) {
      final find = node.addNodeInParent(newNode, parentId);

      if (find != null) {
        return find;
      }
    }

    return null;
  }

  TreeNode? filterNodesWhere(bool Function(TreeNode node) test) {
    if (this.data is AssetModel) {
      if (!test(this) &&
          nodes.every(
            (child) => !child.containsNodeWhere(test),
          )) {
        return null;
      }
      final filteredNode = TreeNode(id: id, name: name, data: data, nodes: {});

      for (final node in nodes) {
        final filteredChild = node.filterNodesWhere(test);
        if (filteredChild != null) {
          filteredNode.addNode(filteredChild);
        }
      }

      return filteredNode;
    } else {
      if (nodes.isEmpty) return null;

      final newNode = TreeNode(
        id: id,
        name: name,
        data: data,
        nodes: {},
      );

      for (final node in nodes) {
        final filteredChild = node.filterNodesWhere(test);
        if (filteredChild != null) {
          newNode.addNode(filteredChild);
        }
      }

      return newNode;
    }
  }

  bool containsNodeWhere(bool Function(TreeNode node) test) {
    if (data is AssetModel) {
      if (test(this)) return true;
    }

    for (final node in nodes) {
      if (node.containsNodeWhere(test)) return true;
    }

    return false;
  }

  AssetsNodeWidget toWidget() => AssetsNodeWidget(
        node: this,
      );

  @override
  String toString() {
    return "$name - $data - ${nodes.length}";
  }

  TreeNode<T> copyWith({
    T? data,
    String? id,
    String? name,
    Set<TreeNode<T>>? nodes,
  }) {
    return TreeNode<T>(
      data: data ?? this.data,
      id: id ?? this.id,
      name: name ?? this.name,
      nodes: nodes ?? this.nodes,
    );
  }
}
