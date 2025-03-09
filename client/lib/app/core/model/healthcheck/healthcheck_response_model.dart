import 'dart:convert';

class HealthCheckResponseModel {
  String id;
  String applicationId;
  String createdAt;
  bool success;
  HealthCheckResponseModel({
    required this.id,
    required this.applicationId,
    required this.createdAt,
    required this.success,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'applicationId': applicationId,
      'createdAt': createdAt,
      'success': success,
    };
  }

  factory HealthCheckResponseModel.fromMap(Map<String, dynamic> map) {
    return HealthCheckResponseModel(
      id: map['id'] as String,
      applicationId: map['applicationId'] as String,
      createdAt: map['createdAt'] as String,
      success: map['success'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthCheckResponseModel.fromJson(String source) =>
      HealthCheckResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  static List<HealthCheckResponseModel> fromJsonList(String source) {
    var data = json.decode(source) as List<dynamic>;
    return data.map((e) => HealthCheckResponseModel.fromMap(e)).toList();
  }
}
