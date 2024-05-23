import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_test/core/http_adapter.dart';
import 'package:tractian_test/features/assets/models/asset_model.dart';
import 'package:tractian_test/features/assets/models/location_model.dart';
import 'package:tractian_test/features/assets/repository/assets_repository.dart';

class MockHttpAdapter extends Mock implements HttpAdapter {}

void main() {
  final HttpAdapter adapter = MockHttpAdapter();

  final mockedLocationsData = [
    {
      "id": "656a07b3f2d4a1001e2144bf",
      "name": "CHARCOAL STORAGE SECTOR",
      "parentId": "65674204664c41001e91ecb4"
    },
    {
      "id": "656733611f4664001f295dd0",
      "name": "Empty Machine house",
      "parentId": null
    },
    {
      "id": "656733b1664c41001e91d9ed",
      "name": "Machinery house",
      "parentId": null
    },
    {
      "id": "65674204664c41001e91ecb4",
      "name": "PRODUCTION AREA - RAW MATERIAL",
      "parentId": null
    },
  ];

  final mockedAssetsData = [
    {
      "id": "656a07bbf2d4a1001e2144c2",
      "locationId": "656a07b3f2d4a1001e2144bf",
      "name": "CONVEYOR BELT ASSEMBLY",
      "parentId": null,
      "sensorType": null,
      "status": null
    },
    {
      "gatewayId": "QHI640",
      "id": "656734821f4664001f296973",
      "locationId": null,
      "name": "Fan - External",
      "parentId": null,
      "sensorId": "MTC052",
      "sensorType": "energy",
      "status": "operating"
    },
    {
      "id": "656734448eb037001e474a62",
      "locationId": "656733b1664c41001e91d9ed",
      "name": "Fan H12D",
      "parentId": null,
      "sensorType": null,
      "status": null
    },
    {
      "gatewayId": "FRH546",
      "id": "656a07cdc50ec9001e84167b",
      "locationId": null,
      "name": "MOTOR RT COAL AF01",
      "parentId": "656a07c3f2d4a1001e2144c5",
      "sensorId": "FIJ309",
      "sensorType": "vibration",
      "status": "operating"
    },
  ];
  group("AssetsRepository", () {
    late AssetsRepository repository;

    setUp(() {
      repository = AssetsRepository(httpAdapter: adapter);
    });

    test("successfully get locations", () async {
      when(
        () => adapter.get("/companies/id/locations"),
      ).thenAnswer((_) async => mockedLocationsData);

      final locations = await repository.getLocations("id");

      expect(locations, isA<List<LocationModel>>());
    });

    test("successfully get assets", () async {
      when(
        () => adapter.get("/companies/id/assets"),
      ).thenAnswer((_) async => mockedAssetsData);

      final companies = await repository.getAssets("id");

      expect(companies, isA<List<AssetModel>>());
    });
  });
}
