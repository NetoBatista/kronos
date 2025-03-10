class LogRequestModel {
  DateTime startDate;
  DateTime endDate;
  String? content;
  String? type;
  String? applicationId;
  LogRequestModel({
    required this.startDate,
    required this.endDate,
    this.content,
    this.type,
    this.applicationId,
  });
}
