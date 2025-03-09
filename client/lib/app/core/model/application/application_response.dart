import 'dart:convert';

class ApplicationResponse {
  String id;
  String key;
  String name;
  String? healthCheck;
  ApplicationResponse({
    required this.id,
    required this.key,
    required this.name,
    this.healthCheck,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'key': key,
      'name': name,
      'healthCheck': healthCheck,
    };
  }

  factory ApplicationResponse.fromMap(Map<String, dynamic> map) {
    return ApplicationResponse(
      id: map['id'] as String,
      key: map['key'] as String,
      name: map['name'] as String,
      healthCheck:
          map['healthCheck'] != null ? map['healthCheck'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplicationResponse.fromJson(String source) =>
      ApplicationResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<ApplicationResponse> fromJsonList(String source) {
    var data = json.decode(source) as List<dynamic>;
    return data.map((e) => ApplicationResponse.fromMap(e)).toList();
  }
}
