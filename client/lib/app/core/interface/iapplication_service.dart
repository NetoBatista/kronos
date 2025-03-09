import 'package:kronos/app/core/model/application/application_request.dart';
import 'package:kronos/app/core/model/application/application_response.dart';
import 'package:kronos/app/shared/tool/result.dart';

abstract class IApplicationService {
  Future<Result<List<ApplicationResponse>, String>> get();
  Future<Result<bool, String>> create(ApplicationRequest request);
  Future<Result<bool, String>> update(ApplicationRequest request);
  Future<Result<bool, String>> delete(String id);
}
