import 'package:kronos/app/core/model/statistic/statistic_response_model.dart';
import 'package:kronos/app/shared/tool/result.dart';

abstract class IStatisticService {
  Future<Result<StatisticResponseModel, String>> get(DateTime selectedDate);
}
