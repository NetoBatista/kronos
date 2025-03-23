import 'dart:convert';

class StatisticResponseModel {
  String applicationId;
  String applicationName;
  int countError;
  int countInfo;
  int countSuccess;
  int total;
  StatisticResponseModel({
    required this.applicationId,
    required this.applicationName,
    required this.countError,
    required this.countInfo,
    required this.countSuccess,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'applicationId': applicationId,
      'applicationName': applicationName,
      'countError': countError,
      'countInfo': countInfo,
      'countSuccess': countSuccess,
      'total': total,
    };
  }

  factory StatisticResponseModel.fromMap(Map<String, dynamic> map) {
    return StatisticResponseModel(
      applicationId: map['applicationId'] as String,
      applicationName: map['applicationName'] as String,
      countError: map['countError'] as int,
      countInfo: map['countInfo'] as int,
      countSuccess: map['countSuccess'] as int,
      total: map['total'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatisticResponseModel.fromJson(String source) =>
      StatisticResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  static List<StatisticResponseModel> fromJsonList(String source) {
    var data = json.decode(source) as List<dynamic>;
    return data.map((e) => StatisticResponseModel.fromMap(e)).toList();
  }
}
