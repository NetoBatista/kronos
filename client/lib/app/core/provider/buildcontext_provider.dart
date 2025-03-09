import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BuildContextProvider {
  static T watch<T extends Object>(
    BuildContext context, [
    SelectCallback<T>? onSelect,
  ]) {
    return context.watch<T>(onSelect);
  }
}
