import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kronos/app/module/app/controller/app_controller.dart';
import 'package:kronos/app/module/app/page/app_page.dart';
import 'package:kronos/app/module/application/application_module.dart';
import 'package:kronos/app/module/core/core_module.dart';
import 'package:kronos/app/module/healthcheck/healthcheck_module.dart';
import 'package:kronos/app/module/home/home_module.dart';
import 'package:kronos/app/module/statistic/statistic_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports {
    return [CoreModule()];
  }

  @override
  void binds(i) {
    i.addLazySingleton(AppController.new);
  }

  @override
  void routes(r) {
    r.redirect('/', to: '/home');
    r.child('/', child: (context) => AppPage(children: [SizedBox()]));
    r.module('/home', module: HomeModule());
    r.module('/application', module: ApplicationModule());
    r.module('/healthcheck', module: HealthCheckModule());
    r.module('/statistic', module: StatisticModule());
  }
}
