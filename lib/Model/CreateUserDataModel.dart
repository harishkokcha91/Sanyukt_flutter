// To parse this JSON data, do
//
//     final createUserDataModel = createUserDataModelFromJson(jsonString);

import 'dart:convert';

CreateUserDataModel createUserDataModelFromJson(String str) => CreateUserDataModel.fromJson(json.decode(str));

String createUserDataModelToJson(CreateUserDataModel data) => json.encode(data.toJson());

class CreateUserDataModel {
  String? status;
  String? msg;
  Data? data;

  CreateUserDataModel({
    this.status,
    this.msg,
    this.data,
  });

  factory CreateUserDataModel.fromJson(Map<String, dynamic> json) => CreateUserDataModel(
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
  List<CreateUserDataElement>? data;

  Data({
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data_"] == null ? [] : List<CreateUserDataElement>.from(json["data_"]!.map((x) => CreateUserDataElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data_": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CreateUserDataElement {
  int? status;
  String? msg;

  CreateUserDataElement({
    this.status,
    this.msg,
  });

  factory CreateUserDataElement.fromJson(Map<String, dynamic> json) => CreateUserDataElement(
    status: json["status"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
  };
}
