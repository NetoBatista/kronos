import 'package:flutter/material.dart';
import 'package:kronos/app/core/interface/istatistic_service.dart';
import 'package:kronos/app/core/model/statistic/statistic_response_model.dart';
import 'package:kronos/app/shared/state/state_shared.dart';

class StatisticController extends ValueNotifier<IStateSharedState> {
  final IStatisticService _statisticService;
  StatisticController(this._statisticService) : super(StateSharedState());

  DateTime currentDate = DateTime.now();
  StatisticResponseModel? statistics;

  Future<void> init() async {
    value.stateIsLoading();
    notifyListeners();
    var response = await _statisticService.get(currentDate);
    statistics = response.success();
    value.error = response.failure() ?? '';
    value.isLoading = false;
    notifyListeners();
  }

  Future<void> onChangeDate(DateTime input) {
    currentDate = input;
    return init();
  }
}
