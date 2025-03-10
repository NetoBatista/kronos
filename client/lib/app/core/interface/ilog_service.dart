import 'package:kronos/app/core/model/log_model/log_request_model.dart';
import 'package:kronos/app/core/model/log_model/log_response_model.dart';
import 'package:kronos/app/shared/tool/result.dart';

abstract class ILogService {
  Future<Result<List<LogResponseModel>, String>> get(LogRequestModel request);
}
