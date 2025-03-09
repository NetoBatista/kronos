import 'package:flutter_modular/flutter_modular.dart';
import 'package:kronos/app/module/app/app_module.dart';
import 'package:kronos/app/module/core/core_module.dart';

class MainModule extends Module {
  @override
  List<Module> get imports {
    return [CoreModule()];
  }

  @override
  void routes(r) {
    r.module('/', module: AppModule());
  }
}
