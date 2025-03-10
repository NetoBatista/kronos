import 'package:kronos/app/core/interface/ilog_service.dart';
import 'package:kronos/app/core/interface/irequest_service.dart';
import 'package:kronos/app/core/model/log_model/log_request_model.dart';
import 'package:kronos/app/core/model/log_model/log_response_model.dart';
import 'package:kronos/app/shared/tool/result.dart';
import 'package:kronos/app/shared/util/date_util.dart';
import 'package:kronos/app/shared/util/url_util.dart';

class LogService implements ILogService {
  final IRequestService _requestService;
  LogService(this._requestService);

  @override
  Future<Result<List<LogResponseModel>, String>> get(
    LogRequestModel request,
  ) async {
    var query = "?";
    query += "startDate=${DateUtil.formatDateToRequest(request.startDate)}";
    query += "&endDate=${DateUtil.formatDateToRequest(request.endDate)}";
    if (request.applicationId != null) {
      query += "&applicationId=${request.applicationId}";
    }
    if (request.content != null) {
      query += "&content=${request.content}";
    }
    if (request.type != null) {
      query += "&type=${request.type}";
    }
    var baseUrl = UrlUtil.baseUrlApi;
    var response = await _requestService.get('$baseUrl/Log$query');
    if (response.statusCode != 200) {
      return Failure('Ocorreu um erro ao buscar os dados');
    }
    return Success(LogResponseModel.fromJsonList(response.body));
  }
}
