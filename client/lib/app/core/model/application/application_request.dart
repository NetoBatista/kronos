import 'dart:convert';

class ApplicationRequest {
  String id;
  String name;
  String? healthCheck;
  ApplicationRequest({required this.id, required this.name, this.healthCheck});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'healthCheck': healthCheck,
    };
  }

  factory ApplicationRequest.fromMap(Map<String, dynamic> map) {
    return ApplicationRequest(
      id: map['id'] as String,
      name: map['name'] as String,
      healthCheck:
          map['healthCheck'] != null ? map['healthCheck'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplicationRequest.fromJson(String source) =>
      ApplicationRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<ApplicationRequest> fromJsonList(String source) {
    var data = json.decode(source) as List<dynamic>;
    return data.map((e) => ApplicationRequest.fromMap(e)).toList();
  }
}
