import 'package:kronos/app/core/interface/iapplication_service.dart';
import 'package:kronos/app/core/interface/irequest_service.dart';
import 'package:kronos/app/core/model/application/application_request.dart';
import 'package:kronos/app/core/model/application/application_response.dart';
import 'package:kronos/app/shared/tool/result.dart';
import 'package:kronos/app/shared/util/url_util.dart';

class ApplicationService implements IApplicationService {
  final IRequestService _requestService;
  ApplicationService(this._requestService);

  @override
  Future<Result<List<ApplicationResponse>, String>> get() async {
    var baseUrl = UrlUtil.baseUrlApi;
    var response = await _requestService.get('$baseUrl/Application');
    if (response.statusCode != 200) {
      return Failure('Ocorreu um erro ao buscar os dados');
    }
    return Success(ApplicationResponse.fromJsonList(response.body));
  }

  @override
  Future<Result<bool, String>> create(ApplicationRequest request) async {
    var baseUrl = UrlUtil.baseUrlApi;
    var response = await _requestService.post(
      '$baseUrl/Application',
      request.toMap(),
    );
    if (response.statusCode != 200) {
      return Failure('Erro ao cadastrar aplicação');
    }
    return Success(true);
  }

  @override
  Future<Result<bool, String>> update(ApplicationRequest request) async {
    var baseUrl = UrlUtil.baseUrlApi;
    var response = await _requestService.patch(
      '$baseUrl/Application',
      request.toMap(),
    );
    if (response.statusCode != 200) {
      return Failure('Erro ao cadastrar aplicação');
    }
    return Success(true);
  }

  @override
  Future<Result<bool, String>> delete(String id) async {
    var baseUrl = UrlUtil.baseUrlApi;
    var response = await _requestService.delete('$baseUrl/Application/$id');
    if (response.statusCode != 200) {
      return Failure('Erro ao cadastrar aplicação');
    }
    return Success(true);
  }
}
