// To parse this JSON data, do
//
//     final vehicleModel = vehicleModelFromJson(jsonString);

import 'dart:convert';

VehicleModel vehicleModelFromJson(String str) => VehicleModel.fromJson(json.decode(str));

String vehicleModelToJson(VehicleModel data) => json.encode(data.toJson());

class VehicleModel {
  List<VehicleDatum>? vehicleData;
  int? status;

  VehicleModel({
    this.vehicleData,
    this.status,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    vehicleData: json["vehicle_data"] == null ? [] : List<VehicleDatum>.from(json["vehicle_data"]!.map((x) => VehicleDatum.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "vehicle_data": vehicleData == null ? [] : List<dynamic>.from(vehicleData!.map((x) => x.toJson())),
    "status": status,
  };
}

class VehicleDatum {
  int? id;
  String? vehicleType;
  DateTime? createdAt;
  DateTime? updatedAt;

  VehicleDatum({
    this.id,
    this.vehicleType,
    this.createdAt,
    this.updatedAt,
  });

  factory VehicleDatum.fromJson(Map<String, dynamic> json) => VehicleDatum(
    id: json["id"],
    vehicleType: json["vehicleType"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vehicleType": vehicleType,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
