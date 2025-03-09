import 'package:kronos/app/core/interface/ihealthcheck_service.dart';
import 'package:kronos/app/core/interface/irequest_service.dart';
import 'package:kronos/app/core/model/healthcheck/healthcheck_response_model.dart';
import 'package:kronos/app/shared/tool/result.dart';
import 'package:kronos/app/shared/util/url_util.dart';

class HealthCheckService implements IHealthCheckService {
  final IRequestService _requestService;
  HealthCheckService(this._requestService);

  @override
  Future<Result<List<HealthCheckResponseModel>, String>> get() async {
    var baseUrl = UrlUtil.baseUrlApi;
    var response = await _requestService.get('$baseUrl/HealthCheck');
    if (response.statusCode != 200) {
      return Failure('Ocorreu um erro ao buscar os dados');
    }
    return Success(HealthCheckResponseModel.fromJsonList(response.body));
  }

  @override
  Future<Result<bool, String>> post() async {
    var baseUrl = UrlUtil.baseUrlApi;
    var response = await _requestService.post(
      '$baseUrl/HealthCheck/Applications',
      {},
    );
    if (response.statusCode != 200) {
      return Failure('Ocorreu um erro ao buscar os dados');
    }
    return Success(true);
  }
}
