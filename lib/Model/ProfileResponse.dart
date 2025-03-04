// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
  List<Datum>? data;
  int? limit;
  int? page;
  int? totalPages;
  int? totalRecords;

  ProfileResponse({
    this.data,
    this.limit,
    this.page,
    this.totalPages,
    this.totalRecords,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    limit: json["limit"],
    page: json["page"],
    totalPages: json["totalPages"],
    totalRecords: json["totalRecords"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "limit": limit,
    "page": page,
    "totalPages": totalPages,
    "totalRecords": totalRecords,
  };
}

class Datum {
  int? id;
  int? userId;
  String? profileFor;
  String? name;
  String? image;
  DateTime? dateOfBirth;
  String? birthPlace;
  String? height;
  String? complexion;
  String? gotraSelf;
  String? gotraMother;
  String? gotraGrandMother;
  bool? manglik;
  String? fatherName;
  String? fatherOccupation;
  String? motherName;
  String? motherOccupation;
  String? siblings;
  String? qualification;
  String? occupation;
  String? annualIncome;
  String? maritalStatus;
  String? address;
  String? currentLocation;
  String? status;
  String? phoneNumbers;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.userId,
    this.profileFor,
    this.name,
    this.image,
    this.dateOfBirth,
    this.birthPlace,
    this.height,
    this.complexion,
    this.gotraSelf,
    this.gotraMother,
    this.gotraGrandMother,
    this.manglik,
    this.fatherName,
    this.fatherOccupation,
    this.motherName,
    this.motherOccupation,
    this.siblings,
    this.qualification,
    this.occupation,
    this.annualIncome,
    this.maritalStatus,
    this.address,
    this.currentLocation,
    this.status,
    this.phoneNumbers,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    profileFor: json["profileFor"],
    name: json["name"],
    image: json["image"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    birthPlace: json["birthPlace"],
    height: json["height"],
    complexion: json["complexion"],
    gotraSelf: json["gotraSelf"],
    gotraMother: json["gotraMother"],
    gotraGrandMother: json["gotraGrandMother"],
    manglik: json["manglik"],
    fatherName: json["fatherName"],
    fatherOccupation: json["fatherOccupation"],
    motherName: json["motherName"],
    motherOccupation: json["motherOccupation"],
    siblings: json["siblings"],
    qualification: json["qualification"],
    occupation: json["occupation"],
    annualIncome: json["annualIncome"],
    maritalStatus: json["maritalStatus"],
    address: json["address"],
    currentLocation: json["currentLocation"],
    status: json["status"],
    phoneNumbers: json["phoneNumbers"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "profileFor": profileFor,
    "name": name,
    "image": image,
    "dateOfBirth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "birthPlace": birthPlace,
    "height": height,
    "complexion": complexion,
    "gotraSelf": gotraSelf,
    "gotraMother": gotraMother,
    "gotraGrandMother": gotraGrandMother,
    "manglik": manglik,
    "fatherName": fatherName,
    "fatherOccupation": fatherOccupation,
    "motherName": motherName,
    "motherOccupation": motherOccupation,
    "siblings": siblings,
    "qualification": qualification,
    "occupation": occupation,
    "annualIncome": annualIncome,
    "maritalStatus": maritalStatus,
    "address": address,
    "currentLocation": currentLocation,
    "status": status,
    "phoneNumbers": phoneNumbers,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
