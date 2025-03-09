import 'package:kronos/app/core/interface/irequest_service.dart';
import 'package:kronos/app/core/interface/istatistic_service.dart';
import 'package:kronos/app/core/model/statistic/statistic_response_model.dart';
import 'package:kronos/app/shared/tool/result.dart';
import 'package:kronos/app/shared/util/url_util.dart';

class StatisticService implements IStatisticService {
  final IRequestService _requestService;
  StatisticService(this._requestService);

  @override
  Future<Result<StatisticResponseModel, String>> get(
    DateTime selectedDate,
  ) async {
    var query = "?StartDate=${selectedDate.year}-${selectedDate.month}-01";
    var finalDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
    query += "&EndDate=${finalDate.year}-${finalDate.month}-01";
    var baseUrl = UrlUtil.baseUrlApi;
    var response = await _requestService.get('$baseUrl/Statistic$query');
    if (response.statusCode != 200) {
      return Failure('Ocorreu um erro ao buscar os dados');
    }
    return Success(StatisticResponseModel.fromJson(response.body));
  }
}
