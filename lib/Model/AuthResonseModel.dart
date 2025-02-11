// To parse this JSON data, do
//
//     final authResponseModel = authResponseModelFromJson(jsonString);

import 'dart:convert';

AuthResponseModel authResponseModelFromJson(String str) => AuthResponseModel.fromJson(json.decode(str));

String authResponseModelToJson(AuthResponseModel data) => json.encode(data.toJson());

class AuthResponseModel {
  String? status;
  String? msg;
  Data? data;

  AuthResponseModel({
    this.status,
    this.msg,
    this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) => AuthResponseModel(
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
  String? username;
  int? userid;
  String? usertype;
  String? tokenid;

  DataElement({
    this.status,
    this.msg,
    this.username,
    this.userid,
    this.usertype,
    this.tokenid,
  });

  factory DataElement.fromJson(Map<String, dynamic> json) => DataElement(
    status: json["status"],
    msg: json["msg"],
    username: json["username"],
    userid: json["userid"],
    usertype: json["usertype"],
    tokenid: json["tokenid"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "username": username,
    "userid": userid,
    "usertype": usertype,
    "tokenid": tokenid,
  };
}
