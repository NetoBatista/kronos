import 'package:flutter/material.dart';
import 'package:kronos/app/core/provider/buildcontext_provider.dart';
import 'package:kronos/app/core/provider/dependency_provider.dart';
import 'package:kronos/app/module/app/page/app_page.dart';
import 'package:kronos/app/module/healthcheck/component/healthcheck_table_component.dart';
import 'package:kronos/app/module/healthcheck/controller/healthcheck_controller.dart';
import 'package:kronos/app/shared/component/item_table_row.dart';
import 'package:kronos/app/shared/component/skeleton_loader.dart';

class HealthCheckPage extends StatefulWidget {
  const HealthCheckPage({super.key});

  @override
  State<HealthCheckPage> createState() => _HealthCheckPageState();
}

class _HealthCheckPageState extends State<HealthCheckPage> {
  HealthCheckController controller = DependencyProvider.get();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller = BuildContextProvider.watch(context);
      await controller.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      children: [
        Text(
          'HealthCheck',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Confira os últimos logs relacionados a saúde de suas aplicações',
          style: TextStyle(fontSize: 18),
        ),
        Row(
          spacing: 16,
          children: [
            FilledButton(
              onPressed: controller.checking ? null : controller.executeCheck,
              child: Text('Executar agora'),
            ),
            Visibility(
              visible: controller.checking,
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ],
        ),
        Visibility(
          visible: controller.value.isLoading,
          child: SkeletonLoader(
            height: MediaQuery.of(context).size.height - 240,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Visibility(
          visible: !controller.value.isLoading,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Table(
              border: TableBorder.all(),
              children:
                  [
                    TableRow(
                      children: [
                        ItemTableRow(
                          child: Text(
                            'Nome',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ItemTableRow(
                          child: Text(
                            'Status',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ItemTableRow(
                          child: Text(
                            'Data',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ] +
                  controller.healthChecks.map((item) {
                    return HealthCheckTableComponent(
                      item,
                      controller.applications,
                    ).build();
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
