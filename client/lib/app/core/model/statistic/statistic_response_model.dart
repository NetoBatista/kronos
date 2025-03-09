import 'dart:convert';

import 'package:kronos/app/core/model/statistic/statistic_count_type_response_model.dart';
import 'package:kronos/app/core/model/statistic/statistic_total_response_model.dart';

class StatisticResponseModel {
  List<StatisticCountTypeResponseModel> countTypes;
  List<StatisticTotalResponseModel> totals;
  StatisticResponseModel({required this.countTypes, required this.totals});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'countTypes': countTypes.map((x) => x.toMap()).toList(),
      'totals': totals.map((x) => x.toMap()).toList(),
    };
  }

  factory StatisticResponseModel.fromMap(Map<String, dynamic> map) {
    return StatisticResponseModel(
      countTypes: List<StatisticCountTypeResponseModel>.from(
        (map['countTypes'] as List<dynamic>)
            .map<StatisticCountTypeResponseModel>(
              (x) => StatisticCountTypeResponseModel.fromMap(
                x as Map<String, dynamic>,
              ),
            ),
      ),
      totals: List<StatisticTotalResponseModel>.from(
        (map['totals'] as List<dynamic>).map<StatisticTotalResponseModel>(
          (x) => StatisticTotalResponseModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory StatisticResponseModel.fromJson(String source) =>
      StatisticResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
