import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_test/core/colors.dart';
import 'package:tractian_test/features/home/screen/widgets/company_list.dart';
import 'package:tractian_test/features/home/state/home_controller.dart';
import 'package:tractian_test/features/home/state/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = GetIt.I();

  @override
  void initState() {
    controller.getCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: TractianColors.appBarBackgroundColor,
        title: SvgPicture.asset("assets/logo.svg"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              final value = controller.value;

              final widget = switch (value) {
                LoadingHomeState _ => Center(
                    child: CircularProgressIndicator(
                      backgroundColor: TractianColors.primaryColor,
                      color: Colors.white,
                    ),
                  ),
                LoadedHomeState state => CompanyList(
                    companies: state.companies,
                  ),
                EmptyHomeState _ => const Center(
                    child: Text("Nenhuma companhia encontrada!"),
                  ),
                HomeState() => throw UnimplementedError(),
              };

              return widget;
            }),
      ),
    );
  }
}
