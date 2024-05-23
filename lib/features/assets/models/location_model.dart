class LocationModel {
  final String id;
  final String name;
  final String? parentId;

  LocationModel({
    required this.id,
    required this.name,
    required this.parentId,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json["id"],
      name: json["name"],
      parentId: json["parentId"],
    );
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return id == (other as LocationModel).id;
  }
}
