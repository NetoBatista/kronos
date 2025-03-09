import 'package:kronos/app/module/core/core_module.dart';
import 'package:kronos/app/module/home/controller/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kronos/app/module/home/page/home_page.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports {
    return [CoreModule()];
  }

  @override
  void binds(i) {
    i.add(HomeController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage());
  }
}
