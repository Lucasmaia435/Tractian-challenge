import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_test/core/colors.dart';
import 'package:tractian_test/features/assets/screen/widgets/assets_tree.dart';
import 'package:tractian_test/features/assets/state/assets_controller.dart';
import 'package:tractian_test/features/assets/state/assets_state.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key, required this.companyId});

  final String companyId;
  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  final AssetsController controller = GetIt.I();

  @override
  void initState() {
    controller.getLocationsAndAssets(widget.companyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: TractianColors.appBarBackgroundColor,
        title: const Text(
          "Assets",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          final value = controller.value;

          final widget = switch (value) {
            LoadingAssetsState _ => Center(
                child: CircularProgressIndicator(
                  backgroundColor: TractianColors.primaryColor,
                  color: Colors.white,
                ),
              ),
            LoadedAssetsState state => AssetsTree(
                state: state,
              ),
            EmptyAssetsState _ => const Center(
                child: Text("Nenhuma companhia encontrada!"),
              ),
            AssetsState() => throw UnimplementedError(),
          };

          return widget;
        },
      ),
    );
  }
}
