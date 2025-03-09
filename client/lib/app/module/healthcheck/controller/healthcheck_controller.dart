import 'package:flutter/material.dart';
import 'package:kronos/app/core/interface/iapplication_service.dart';
import 'package:kronos/app/core/interface/ihealthcheck_service.dart';
import 'package:kronos/app/core/model/application/application_response.dart';
import 'package:kronos/app/core/model/healthcheck/healthcheck_response_model.dart';
import 'package:kronos/app/shared/state/state_shared.dart';

class HealthCheckController extends ValueNotifier<IStateSharedState> {
  final IHealthCheckService _healthCheckService;
  final IApplicationService _applicationService;
  HealthCheckController(this._healthCheckService, this._applicationService)
    : super(StateSharedState());

  final List<HealthCheckResponseModel> healthChecks = [];
  final List<ApplicationResponse> applications = [];
  bool checking = false;

  Future<void> init() async {
    healthChecks.clear();
    value.stateIsLoading();
    notifyListeners();

    var responseHealthChecks = await _healthCheckService.get();

    healthChecks.addAll(responseHealthChecks.success() ?? []);
    value.error = responseHealthChecks.failure() ?? '';

    var responseApplications = await _applicationService.get();

    applications.addAll(responseApplications.success() ?? []);
    if (value.error.isEmpty) {
      value.error = responseApplications.failure() ?? '';
    }

    value.isLoading = false;
    notifyListeners();
  }

  Future<void> executeCheck() async {
    notifyListeners();
    checking = true;
    await _healthCheckService.post();
    checking = false;
    await init();
  }
}
