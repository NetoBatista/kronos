import 'package:flutter_modular/flutter_modular.dart';
import 'package:kronos/app/module/core/core_module.dart';
import 'package:kronos/app/module/statistic/controller/statistic_controller.dart';
import 'package:kronos/app/module/statistic/page/statistic_page.dart';

class StatisticModule extends Module {
  @override
  List<Module> get imports {
    return [CoreModule()];
  }

  @override
  void binds(i) {
    i.add(StatisticController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => StatisticPage());
  }
}
