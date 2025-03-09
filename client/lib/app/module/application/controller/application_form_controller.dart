import 'package:flutter/material.dart';
import 'package:kronos/app/core/interface/iapplication_service.dart';
import 'package:kronos/app/core/model/application/application_request.dart';
import 'package:kronos/app/core/provider/navigator_provider.dart';
import 'package:kronos/app/shared/state/state_shared.dart';

class ApplicationFormController extends ValueNotifier<IStateSharedState> {
  final IApplicationService _applicationService;
  ApplicationFormController(this._applicationService)
    : super(StateSharedState());

  Future<void> create(ApplicationRequest request) async {
    value.stateIsLoading();
    notifyListeners();
    var response = await _applicationService.create(request);
    value.error = response.failure() ?? '';
    if (response.success() == true) {
      NavigatorProvider.pop();
    } else {
      notifyListeners();
    }
  }

  Future<void> update(ApplicationRequest request) async {
    value.stateIsLoading();
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    var response = await _applicationService.update(request);
    value.error = response.failure() ?? '';
    if (response.success() == true) {
      NavigatorProvider.pop();
    } else {
      notifyListeners();
    }
  }

  Future<void> delete(ApplicationRequest request) async {
    value.stateIsLoading();
    notifyListeners();
    var response = await _applicationService.delete(request.id);
    value.error = response.failure() ?? '';
    if (response.success() == true) {
      NavigatorProvider.pop();
    } else {
      notifyListeners();
    }
  }
}
