import 'package:tractian_test/features/home/models/companie_model.dart';

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {
  final List<CompanyModel> companies;

  LoadedHomeState({required this.companies});
}

class EmptyHomeState extends HomeState {}
