import 'package:flutter_modular/flutter_modular.dart';
import 'package:kronos/app/module/application/controller/application_controller.dart';
import 'package:kronos/app/module/application/controller/application_form_controller.dart';
import 'package:kronos/app/module/application/page/application_form_page.dart';
import 'package:kronos/app/module/application/page/application_page.dart';
import 'package:kronos/app/module/core/core_module.dart';

class ApplicationModule extends Module {
  @override
  List<Module> get imports {
    return [CoreModule()];
  }

  @override
  void binds(i) {
    i.add(ApplicationController.new);
    i.add(ApplicationFormController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => ApplicationPage());
    r.child(
      '/form',
      child: (context) => ApplicationFormPage(application: r.args.data),
    );
  }
}
