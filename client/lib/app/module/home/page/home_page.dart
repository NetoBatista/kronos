import 'package:kronos/app/core/constant/log_type_constant.dart';
import 'package:kronos/app/core/model/log/log_request_model.dart';
import 'package:kronos/app/core/provider/buildcontext_provider.dart';
import 'package:kronos/app/core/provider/dependency_provider.dart';
import 'package:kronos/app/module/app/page/app_page.dart';
import 'package:kronos/app/module/home/component/home_log_component.dart';
import 'package:kronos/app/module/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:kronos/app/shared/component/skeleton_loader.dart';
import 'package:kronos/app/shared/util/date_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = DependencyProvider.get();
  LogRequestModel request = LogRequestModel(
    startDate: DateTime.now(),
    endDate: DateTime.now(),
  );
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    request.startDate = DateTime(
      request.endDate.year,
      request.endDate.month,
      1,
    );
    startDateController.text = DateUtil.formatDate(request.startDate);
    endDateController.text = DateUtil.formatDate(request.endDate);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller = BuildContextProvider.watch(context);
      await controller.init();
      await controller.search(request);
    });
  }

  void onTapSearch() {
    controller.search(request);
  }

  void onChangeApplication(String? application) {
    request.applicationId = application;
    controller.notify();
  }

  void onChangeLogType(String? type) {
    request.type = type;
    controller.notify();
  }

  void onChangeContent(String? content) {
    request.content = content;
    controller.notify();
  }

  Future<void> onTapStartDate() async {
    var response = await showDatePicker(
      locale: Locale('pt', 'BR'),
      context: context,
      initialDate: request.startDate,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (response == null) {
      return;
    }
    request.startDate = response;
    startDateController.text = DateUtil.formatDate(request.startDate);
    controller.notify();
  }

  Future<void> onTapEndDate() async {
    var response = await showDatePicker(
      locale: Locale('pt', 'BR'),
      context: context,
      initialDate: request.endDate,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (response == null) {
      return;
    }
    request.endDate = response;
    endDateController.text = DateUtil.formatDate(request.endDate);
    controller.notify();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      children: [
        Text(
          'Início',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            SizedBox(
              width: 400,
              child: TextFormField(
                enabled: !controller.value.isLoading,
                onChanged: onChangeContent,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_outlined),
                  labelText: 'Pesquisar',
                  hintText: '',
                ),
              ),
            ),
            SizedBox(
              height: 48,
              child: FilledButton(
                onPressed: controller.value.isLoading ? null : onTapSearch,
                child: Text('Pesquisar'),
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Card(
              child: SizedBox(
                width: 200,
                child: DropdownButton<String>(
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  isExpanded: true,
                  value: request.applicationId,
                  underline: SizedBox(),
                  onChanged:
                      controller.value.isLoading ? null : onChangeApplication,
                  items: controller.getDropdownMenuItemApplication(),
                ),
              ),
            ),
            Card(
              child: SizedBox(
                width: 160,
                child: DropdownButton<String>(
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  isExpanded: true,
                  value: request.type,
                  underline: SizedBox(),
                  onChanged:
                      controller.value.isLoading ? null : onChangeLogType,
                  items: [
                    DropdownMenuItem(value: null, child: Text('Todos')),
                    DropdownMenuItem(
                      value: LogTypeConstant.success,
                      child: Text(
                        LogTypeConstant.translate(LogTypeConstant.success),
                      ),
                    ),
                    DropdownMenuItem(
                      value: LogTypeConstant.info,
                      child: Text(
                        LogTypeConstant.translate(LogTypeConstant.info),
                      ),
                    ),
                    DropdownMenuItem(
                      value: LogTypeConstant.error,
                      child: Text(
                        LogTypeConstant.translate(LogTypeConstant.error),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text('De'),
            SizedBox(
              width: 160,
              child: TextFormField(
                readOnly: true,
                enabled: !controller.value.isLoading,
                controller: startDateController,
                onTap: onTapStartDate,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.date_range_outlined),
                ),
              ),
            ),
            Text('Até'),
            SizedBox(
              width: 160,
              child: TextFormField(
                readOnly: true,
                enabled: !controller.value.isLoading,
                controller: endDateController,
                onTap: onTapEndDate,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.date_range_outlined),
                ),
              ),
            ),
          ],
        ),

        if (controller.value.isLoading)
          SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 10,
              padding: EdgeInsets.only(right: 16),
              separatorBuilder: (BuildContext _, int index) {
                return SizedBox(height: 8);
              },
              itemBuilder: (BuildContext _, int index) {
                return SkeletonLoader(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                );
              },
            ),
          ),
        if (!controller.value.isLoading)
          SizedBox(
            height: MediaQuery.of(context).size.height - 280,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: controller.logs.length,
              padding: EdgeInsets.only(right: 16),
              separatorBuilder: (BuildContext _, int index) {
                return SizedBox(height: 8);
              },
              itemBuilder: (BuildContext _, int index) {
                var item = controller.logs.elementAt(index);
                return HomeLogComponent(log: item, controller: controller);
              },
            ),
          ),
      ],
    );
  }
}
