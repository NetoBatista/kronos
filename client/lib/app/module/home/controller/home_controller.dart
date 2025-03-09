import 'package:kronos/app/core/interface/iapplication_service.dart';
import 'package:kronos/app/core/interface/ilog_service.dart';
import 'package:kronos/app/core/model/application/application_response.dart';
import 'package:kronos/app/core/model/log/log_request_model.dart';
import 'package:kronos/app/core/model/log/log_response_model.dart';
import 'package:kronos/app/shared/state/state_shared.dart';
import 'package:flutter/material.dart';

class HomeController extends ValueNotifier<IStateSharedState> {
  final ILogService _logService;
  final IApplicationService _applicationService;
  HomeController(this._logService, this._applicationService)
    : super(StateSharedState());

  final List<LogResponseModel> logs = [];
  final List<ApplicationResponse> applications = [];

  Future<void> init() async {
    value.stateIsLoading();
    notifyListeners();
    var response = await _applicationService.get();
    applications.clear();
    applications.addAll(response.success() ?? []);
    value.error = response.failure() ?? '';
    value.isLoading = false;
    notifyListeners();
  }

  Future<void> search(LogRequestModel request) async {
    logs.clear();
    value.stateIsLoading();
    notifyListeners();

    var response = await _logService.get(request);

    logs.addAll(response.success() ?? []);
    value.error = response.failure() ?? '';
    value.isLoading = false;
    notifyListeners();
  }

  List<DropdownMenuItem<String>> getDropdownMenuItemApplication() {
    List<DropdownMenuItem<String>> response = [];
    response.add(DropdownMenuItem<String>(value: null, child: Text('Todos')));
    for (var application in applications) {
      response.add(
        DropdownMenuItem<String>(
          value: application.id,
          child: Text(application.name),
        ),
      );
    }
    return response;
  }

  void notify() => notifyListeners();
}
