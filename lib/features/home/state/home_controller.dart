import 'package:flutter/material.dart';
import 'package:tractian_test/features/home/repository/home_repository.dart';
import 'package:tractian_test/features/home/state/home_state.dart';

class HomeController extends ValueNotifier<HomeState> {
  HomeController({required this.repository}) : super(InitialHomeState());

  final HomeRepository repository;

  Future<void> getCompanies() async {
    value = LoadingHomeState();

    final companies = await repository.getCompanies();

    if (companies.isEmpty) {
      value = EmptyHomeState();

      return;
    }

    value = LoadedHomeState(companies: companies);
  }
}
