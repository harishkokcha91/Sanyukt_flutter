// To parse this JSON data, do
//
//     final driverJobStartDataModel = driverJobStartDataModelFromJson(jsonString);

import 'dart:convert';

DriverJobStartDataModel driverJobStartDataModelFromJson(String str) => DriverJobStartDataModel.fromJson(json.decode(str));

String driverJobStartDataModelToJson(DriverJobStartDataModel data) => json.encode(data.toJson());

class DriverJobStartDataModel {
  String? status;
  String? msg;
  Data? data;

  DriverJobStartDataModel({
    this.status,
    this.msg,
    this.data,
  });

  factory DriverJobStartDataModel.fromJson(Map<String, dynamic> json) => DriverJobStartDataModel(
    status: json["status"],
    msg: json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  List<DataElement>? data;

  Data({
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data_"] == null ? [] : List<DataElement>.from(json["data_"]!.map((x) => DataElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data_": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataElement {
  int? status;
  String? msg;
  int? driverJobId;

  DataElement({
    this.status,
    this.msg,
    this.driverJobId,
  });

  factory DataElement.fromJson(Map<String, dynamic> json) => DataElement(
    status: json["status"],
    msg: json["msg"],
    driverJobId: json["driver_job_id"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "driver_job_id": driverJobId,
  };
}
