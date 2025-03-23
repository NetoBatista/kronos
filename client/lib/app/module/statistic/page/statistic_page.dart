import 'package:flutter/material.dart';
import 'package:kronos/app/core/provider/buildcontext_provider.dart';
import 'package:kronos/app/core/provider/dependency_provider.dart';
import 'package:kronos/app/module/app/page/app_page.dart';
import 'package:kronos/app/module/statistic/component/statistic_item_component.dart';
import 'package:kronos/app/module/statistic/controller/statistic_controller.dart';
import 'package:kronos/app/shared/component/month_year_select_component.dart';
import 'package:kronos/app/shared/component/skeleton_loader.dart';
import 'package:kronos/app/shared/util/date_util.dart';

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
        Card(
          child: InkWell(
            onTap: controller.value.isLoading ? null : onTapMonth,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.date_range_outlined,
                    size: 32,
                    color: controller.value.isLoading ? Colors.grey : null,
                  ),
                  Text(
                    '${DateUtil.getMonth(controller.currentDate.month - 1)} de ${controller.currentDate.year}',
                    style: TextStyle(
                      fontSize: 22,
                      color: controller.value.isLoading ? Colors.grey : null,
                    ),
                  ),
                  Icon(
                    Icons.change_circle_outlined,
                    size: 32,
                    color: controller.value.isLoading ? Colors.grey : null,
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: controller.value.isLoading,
          child: Wrap(
            runSpacing: 8,
            spacing: 8,
            children: List.generate(5, (int index) {
              return SkeletonLoader(height: 200, width: 400);
            }),
          ),
        ),
        Visibility(
          visible: !controller.value.isLoading,
          child: Wrap(
            runSpacing: 8,
            spacing: 8,
            children: List.generate(controller.statistics.length, (int index) {
              var statistic = controller.statistics.elementAt(index);
              return StatisticItemComponent(statistic: statistic);
            }),
          ),
        ),
      ],
    );
  }
}
