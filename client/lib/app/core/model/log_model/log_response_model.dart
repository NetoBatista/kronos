import 'dart:convert';

class LogResponseModel {
  String id;
  String applicationId;
  String content;
  String createdAt;
  String type;
  LogResponseModel({
    required this.id,
    required this.applicationId,
    required this.content,
    required this.createdAt,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'applicationId': applicationId,
      'content': content,
      'createdAt': createdAt,
      'type': type,
    };
  }

  factory LogResponseModel.fromMap(Map<String, dynamic> map) {
    return LogResponseModel(
      id: map['id'] as String,
      applicationId: map['applicationId'] as String,
      content: map['content'] as String,
      createdAt: map['createdAt'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogResponseModel.fromJson(String source) =>
      LogResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<LogResponseModel> fromJsonList(String source) {
    var data = json.decode(source) as List<dynamic>;
    return data.map((e) => LogResponseModel.fromMap(e)).toList();
  }
}
