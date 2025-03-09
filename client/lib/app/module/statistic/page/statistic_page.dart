import 'package:flutter/material.dart';
import 'package:kronos/app/core/provider/buildcontext_provider.dart';
import 'package:kronos/app/core/provider/dependency_provider.dart';
import 'package:kronos/app/module/app/page/app_page.dart';
import 'package:kronos/app/module/statistic/controller/statistic_controller.dart';
import 'package:kronos/app/shared/component/month_year_select_component.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  StatisticController controller = DependencyProvider.get();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller = BuildContextProvider.watch(context);
      await controller.init();
    });
  }

  Future<void> onTapMonth() async {
    var response = await MonthYearSelectDialogComponent().showMonthYearDialog(
      context: context,
      currentDate: controller.currentDate,
    );
    if (response == null) {
      return;
    }

    controller.onChangeDate(response);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      children: [
        Text(
          'Estatística',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
