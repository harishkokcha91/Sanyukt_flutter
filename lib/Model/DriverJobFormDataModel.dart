class DriverJobFormDataModel{
  String? siteName;
  String? ticketNumber;
  String? childTicketNumber;
  String? faCode;
  String? ticketType;
  String? gallonInGenerator;
  String? pricePerGallonGenerator;
  String? generatorHr;
  String? generatorMin;
  String? matsId;
  String? selCloseOrUpdated;
  String? gallonInTruck;
  String? pricePerGallon;
  String? description;
  String? driverJobId;
  String? jobStartTime;
  String? jobEndTime;
  String? userLat;
  String? userLong;
  String? saveType;

  DriverJobFormDataModel({
    required this.siteName,
    required this.ticketNumber,
    required this.faCode,
    required this.ticketType,
    required this.gallonInGenerator,
    required this.pricePerGallonGenerator,
    required this.generatorHr,
    required this.generatorMin,
    required this.matsId,
    required this.gallonInTruck,
    required this.pricePerGallon,
    this.description,
    this.childTicketNumber,
    this.selCloseOrUpdated,
    required this.driverJobId,
    required this.jobEndTime,
    required this.jobStartTime,
    required this.userLat,
    required this.userLong,
    required this.saveType
  });

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'siteName': siteName,
      'ticketNumber': ticketNumber,
      'faCode': faCode,
      'ticketType': ticketType,
      'gallonInGenerator': gallonInGenerator,
      'pricePerGallonGenerator': pricePerGallonGenerator,
      'generatorHr': generatorHr,
      'generatorMin': generatorMin,
      'matsId': matsId,
      'gallonInTruck': gallonInTruck,
      'pricePerGallon': pricePerGallon,
      'description': description,
      'childTicketNumber': childTicketNumber,
      'selCloseOrUpdated': selCloseOrUpdated,
      'driverJobId': driverJobId,
      'jobEndTime': jobEndTime,
      'jobStartTime': jobStartTime,
      'userLat': userLat,
      'userLong': userLong,
      "saveType":saveType

    };
  }

  // Convert JSON to object
  factory DriverJobFormDataModel.fromJson(Map<String, dynamic> json) {
    return DriverJobFormDataModel(
      siteName: json['siteName'],
      ticketNumber: json['ticketNumber'],
      faCode: json['faCode'],
      ticketType: json['ticketType'],
      gallonInGenerator: json['gallonInGenerator'],
      pricePerGallonGenerator: json['pricePerGallonGenerator'],
      generatorHr: json['generatorHr'],
      generatorMin: json['generatorMin'],
      matsId: json['matsId'],
      gallonInTruck: json['gallonInTruck'],
      pricePerGallon: json['pricePerGallon'],
      description: json['description'],
      childTicketNumber: json['childTicketNumber'],
      selCloseOrUpdated: json['selCloseOrUpdated'],
      driverJobId: json['driverJobId'],
      jobEndTime: json['jobEndTime'],
      jobStartTime: json['jobStartTime'],
      userLat: json['userLat'],
      userLong: json['userLong'],
        saveType:json['saveType']
    );
  }


}