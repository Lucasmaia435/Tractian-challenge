import 'package:tractian_test/features/assets/models/tree_node.dart';

TreeNode<dynamic>? filterTree<T>(
  TreeNode<dynamic> root,
  bool Function(T) predicate,
) {
  final Set<TreeNode> filteredNodes = {};
  for (TreeNode node in root.nodes) {
    final filteredNode = filterTree(node, predicate);

    if (filteredNode != null) {
      filteredNodes.add(filteredNode);
    }
  }

  if (root.data is T && predicate(root.data)) {
    return TreeNode(
      id: root.id,
      name: root.name,
      data: root.data,
      nodes: filteredNodes,
    );
  } else if (filteredNodes.isNotEmpty) {
    return TreeNode(
      id: root.id,
      name: root.name,
      data: root.data,
      nodes: filteredNodes,
    );
  }

  return null;
}
