import 'package:flutter/material.dart';
import 'package:kronos/app/core/interface/iapplication_service.dart';
import 'package:kronos/app/core/model/application/application_response.dart';
import 'package:kronos/app/shared/state/state_shared.dart';

class ApplicationController extends ValueNotifier<IStateSharedState> {
  final IApplicationService _applicationService;
  ApplicationController(this._applicationService) : super(StateSharedState());

  final List<ApplicationResponse> applications = [];
  String filter = '';

  Future<void> init() async {
    filter = '';
    applications.clear();
    value.stateIsLoading();
    notifyListeners();

    var response = await _applicationService.get();

    applications.addAll(response.success() ?? []);
    value.error = response.failure() ?? '';
    value.isLoading = false;
    notifyListeners();
  }

  List<ApplicationResponse> getApplications() {
    if (filter.isEmpty) {
      return applications;
    }
    return applications
        .where(
          (x) =>
              x.name.toLowerCase().contains(filter) ||
              x.key.contains(filter) ||
              x.id.contains(filter),
        )
        .toList();
  }

  void onChangeFilter(String? input) {
    filter = input ?? '';
    notifyListeners();
  }
}
