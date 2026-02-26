// To parse this JSON data, do
//
//     final reportsScreenDataModel = reportsScreenDataModelFromJson(jsonString);

import 'dart:convert';

ReportsScreenDataModel reportsScreenDataModelFromJson(String str) => ReportsScreenDataModel.fromJson(json.decode(str));

String reportsScreenDataModelToJson(ReportsScreenDataModel data) => json.encode(data.toJson());

class ReportsScreenDataModel {
  String? message;
  int? total;
  List<Visitor>? visitors;
  int? status;

  ReportsScreenDataModel({
    this.message,
    this.total,
    this.visitors,
    this.status,
  });

  factory ReportsScreenDataModel.fromJson(Map<String, dynamic> json) => ReportsScreenDataModel(
    message: json["message"],
    total: json["total"],
    visitors: json["visitors"] == null ? [] : List<Visitor>.from(json["visitors"]!.map((x) => Visitor.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "total": total,
    "visitors": visitors == null ? [] : List<dynamic>.from(visitors!.map((x) => x.toJson())),
    "status": status,
  };
}

class Visitor {
  int? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? companyName;
  String? vehicleNumber;
  String? vehicleType;
  String? numberOfItems;
  String? itemTypes;
  String? host;
  String? department;
  DateTime? date;
  String? time;
  String? createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;
  String? approvedBy;
  DateTime? approvedAt;
  dynamic rejectedBy;
  dynamic rejectedAt;
  String? checkoutBy;
  DateTime? checkoutAt;
  String? appointmentStatus;

  Visitor({
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.companyName,
    this.vehicleNumber,
    this.vehicleType,
    this.numberOfItems,
    this.itemTypes,
    this.host,
    this.department,
    this.date,
    this.time,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.approvedBy,
    this.approvedAt,
    this.rejectedBy,
    this.rejectedAt,
    this.checkoutBy,
    this.checkoutAt,
    this.appointmentStatus,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) => Visitor(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    companyName: json["companyName"],
    vehicleNumber: json["vehicleNumber"],
    vehicleType: json["vehicleType"],
    numberOfItems: json["numberOfItems"],
    itemTypes: json["itemTypes"],
    host: json["host"],
    department: json["department"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"],
    createdBy: json["createdBy"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedBy: json["updatedBy"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    approvedBy: json["approvedBy"],
    approvedAt: json["approvedAt"] == null ? null : DateTime.parse(json["approvedAt"]),
    rejectedBy: json["rejectedBy"],
    rejectedAt: json["rejectedAt"],
    checkoutBy: json["checkoutBy"],
    checkoutAt: json["checkoutAt"] == null ? null : DateTime.parse(json["checkoutAt"]),
    appointmentStatus: json["appointmentStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobileNumber": mobileNumber,
    "companyName": companyName,
    "vehicleNumber": vehicleNumber,
    "vehicleType": vehicleType,
    "numberOfItems": numberOfItems,
    "itemTypes": itemTypes,
    "host": host,
    "department": department,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time": time,
    "createdBy": createdBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedBy": updatedBy,
    "updatedAt": updatedAt?.toIso8601String(),
    "approvedBy": approvedBy,
    "approvedAt": approvedAt?.toIso8601String(),
    "rejectedBy": rejectedBy,
    "rejectedAt": rejectedAt,
    "checkoutBy": checkoutBy,
    "checkoutAt": checkoutAt?.toIso8601String(),
    "appointmentStatus": appointmentStatus,
  };
}
