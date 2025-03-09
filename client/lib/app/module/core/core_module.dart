import 'package:kronos/app/core/interface/iapplication_service.dart';
import 'package:kronos/app/core/interface/ihealthcheck_service.dart';
import 'package:kronos/app/core/interface/ilocal_storage_service.dart';
import 'package:kronos/app/core/interface/ilog_service.dart';
import 'package:kronos/app/core/interface/irequest_service.dart';
import 'package:kronos/app/core/interface/istatistic_service.dart';
import 'package:kronos/app/core/service/application_service.dart';
import 'package:kronos/app/core/service/healthcheck_service.dart';
import 'package:kronos/app/core/service/local_storage_service.dart';
import 'package:kronos/app/core/service/log_service.dart';
import 'package:kronos/app/core/service/request_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kronos/app/core/service/statistic_service.dart';
import 'package:kronos/app/module/core/controller/theme_controller.dart';

class CoreModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<IRequestService>(RequestService.new);
    i.addLazySingleton<ILogService>(LogService.new);
    i.addLazySingleton<IApplicationService>(ApplicationService.new);
    i.addLazySingleton<IHealthCheckService>(HealthCheckService.new);
    i.addLazySingleton<IStatisticService>(StatisticService.new);
    i.addLazySingleton<ILocalStorageService>(LocalStorageService.new);
    i.addLazySingleton(ThemeController.new);
  }
}
