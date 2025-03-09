import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kronos/main_module.dart';
import 'package:kronos/main_widget.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(ModularApp(module: MainModule(), child: const MainWidget()));
}
