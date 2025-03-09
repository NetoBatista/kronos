import 'package:flutter_modular/flutter_modular.dart';
import 'package:kronos/app/module/core/core_module.dart';
import 'package:kronos/app/module/healthcheck/controller/healthcheck_controller.dart';
import 'package:kronos/app/module/healthcheck/page/healthcheck_page.dart';

class HealthCheckModule extends Module {
  @override
  List<Module> get imports {
    return [CoreModule()];
  }

  @override
  void binds(i) {
    i.add(HealthCheckController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => HealthCheckPage());
  }
}
