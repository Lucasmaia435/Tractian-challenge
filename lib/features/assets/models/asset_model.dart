enum ComponentStatus { operating, alert }

class AssetModel {
  final String id;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final ComponentStatus? status;
  final String? gatewayId;
  final String? locationId;

  AssetModel({
    required this.id,
    required this.name,
    required this.parentId,
    required this.sensorId,
    required this.sensorType,
    required this.status,
    required this.gatewayId,
    required this.locationId,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json["id"],
      name: json["name"],
      parentId: json["parentId"],
      sensorId: json["sensorId"],
      sensorType: json["sensorType"],
      status: json["status"] == "operating"
          ? ComponentStatus.operating
          : ComponentStatus.alert,
      gatewayId: json["gatewayId"],
      locationId: json["locationId"],
    );
  }

  bool get isExternal => locationId == null && parentId == null;

  bool get isComponent => sensorType != null;

  bool get isAsset => locationId != null && sensorId == null;

  bool get isSubAsset => parentId != null && sensorId == null;

  bool get isExternalComponent => isExternal && isComponent;

  bool get isLocationComponent => isComponent && locationId != null;

  bool get isAssetComponent => isComponent && parentId != null;

  bool get isEnergySensor => isComponent && sensorType == "energy";

  bool get isCritic => isComponent && status == ComponentStatus.alert;

  bool get isOperating => isComponent && status == ComponentStatus.operating;

  int getPriority() {
    if (isAsset) {
      return 1;
    }
    if (isSubAsset) {
      return 2;
    }

    if (isComponent) {
      return 3;
    }

    return 4;
  }

  static int compare(AssetModel a, AssetModel b) {
    return a.getPriority().compareTo(b.getPriority());
  }
}
