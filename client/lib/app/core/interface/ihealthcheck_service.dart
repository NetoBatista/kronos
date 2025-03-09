import 'package:kronos/app/core/model/healthcheck/healthcheck_response_model.dart';
import 'package:kronos/app/shared/tool/result.dart';

abstract class IHealthCheckService {
  Future<Result<List<HealthCheckResponseModel>, String>> get();
  Future<Result<bool, String>> post();
}
