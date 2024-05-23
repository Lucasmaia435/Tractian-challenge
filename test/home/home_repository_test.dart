import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_test/core/http_adapter.dart';
import 'package:tractian_test/features/home/models/companie_model.dart';
import 'package:tractian_test/features/home/repository/home_repository.dart';

class MockHttpAdapter extends Mock implements HttpAdapter {}

void main() {
  final HttpAdapter adapter = MockHttpAdapter();

  final mockedCompaniesData = [
    {"id": "662fd0ee639069143a8fc387", "name": "Jaguar"},
    {"id": "662fd0fab3fd5656edb39af5", "name": "Tobias"},
    {"id": "662fd100f990557384756e58", "name": "Apex"}
  ];
  group("HomeRepository", () {
    late HomeRepository repository;

    setUp(() {
      repository = HomeRepository(httpAdapter: adapter);
    });

    test("successfully get companies", () async {
      when(
        () => adapter.get(any<String>()),
      ).thenAnswer((_) async => mockedCompaniesData);

      final companies = await repository.getCompanies();

      expect(companies, isA<List<CompanyModel>>());
    });
  });
}
