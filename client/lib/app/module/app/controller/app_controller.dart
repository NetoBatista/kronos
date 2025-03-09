import 'package:flutter/material.dart';
import 'package:kronos/app/core/provider/navigator_provider.dart';
import 'package:kronos/app/shared/state/state_shared.dart';

class AppController extends ValueNotifier<IStateSharedState> {
  AppController() : super(StateSharedState());

  void init() {
    if (NavigatorProvider.path() == '/') {
      NavigatorProvider.navigate('/home/');
    }
  }
}
