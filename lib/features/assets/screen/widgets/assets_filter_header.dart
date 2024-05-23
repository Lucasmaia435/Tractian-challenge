import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_test/features/assets/screen/widgets/assets_filter_button.dart';
import 'package:tractian_test/features/assets/screen/widgets/assets_filter_text_field.dart';
import 'package:tractian_test/features/assets/state/assets_controller.dart';
import 'package:tractian_test/features/assets/state/assets_state.dart';

class AssetsFilterHeader extends StatefulWidget {
  const AssetsFilterHeader({super.key});

  @override
  State<AssetsFilterHeader> createState() => _AssetsFilterHeaderState();
}

class _AssetsFilterHeaderState extends State<AssetsFilterHeader> {
  final controller = GetIt.I<AssetsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AssetsFilterTextField(
                onChanged: controller.search,
              ),
              const SizedBox(
                height: 8,
              ),
              ListenableBuilder(
                listenable: controller,
                builder: (context, _) => Row(
                  children: [
                    AssetsFilterButton(
                      label: 'Sensor de Energia',
                      icon: Icons.bolt,
                      isActive:
                          (controller.value as LoadedAssetsState).onlyEletric,
                      onPressed: controller.toggleEnergyFilter,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    AssetsFilterButton(
                      label: 'Crítico',
                      icon: Icons.error_outline,
                      isActive:
                          (controller.value as LoadedAssetsState).onlyCritic,
                      onPressed: controller.toggleCriticFilter,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Color(0xFFD8DFE6),
          height: 0,
        )
      ],
    );
  }
}
