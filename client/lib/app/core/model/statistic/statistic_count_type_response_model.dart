import 'dart:convert';

class StatisticCountTypeResponseModel {
  String applicationId;
  String applicationName;
  int countError;
  int countInfo;
  int countSuccess;
  StatisticCountTypeResponseModel({
    required this.applicationId,
    required this.applicationName,
    required this.countError,
    required this.countInfo,
    required this.countSuccess,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'applicationId': applicationId,
      'applicationName': applicationName,
      'countError': countError,
      'countInfo': countInfo,
      'countSuccess': countSuccess,
    };
  }

  factory StatisticCountTypeResponseModel.fromMap(Map<String, dynamic> map) {
    return StatisticCountTypeResponseModel(
      applicationId: map['applicationId'] as String,
      applicationName: map['applicationName'] as String,
      countError: map['countError'] as int,
      countInfo: map['countInfo'] as int,
      countSuccess: map['countSuccess'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatisticCountTypeResponseModel.fromJson(String source) =>
      StatisticCountTypeResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
