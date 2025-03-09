import 'dart:convert';

class StatisticTotalResponseModel {
  String applicationId;
  String applicationName;
  int total;
  StatisticTotalResponseModel({
    required this.applicationId,
    required this.applicationName,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'applicationId': applicationId,
      'applicationName': applicationName,
      'total': total,
    };
  }

  factory StatisticTotalResponseModel.fromMap(Map<String, dynamic> map) {
    return StatisticTotalResponseModel(
      applicationId: map['applicationId'] as String,
      applicationName: map['applicationName'] as String,
      total: map['total'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatisticTotalResponseModel.fromJson(String source) =>
      StatisticTotalResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
