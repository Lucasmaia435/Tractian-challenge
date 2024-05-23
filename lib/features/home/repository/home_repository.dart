import 'package:tractian_test/core/http_adapter.dart';
import 'package:tractian_test/features/home/models/companie_model.dart';

class HomeRepository {
  final HttpAdapter httpAdapter;

  HomeRepository({
    required this.httpAdapter,
  });

  Future<List<CompanyModel>> getCompanies() async {
    final companiesData = await httpAdapter.get("/companies");

    final List<CompanyModel> companies = List.from(
      companiesData.map(
        (json) => CompanyModel.fromJson(json),
      ),
    );

    return companies;
  }
}
