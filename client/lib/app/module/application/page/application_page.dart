import 'package:flutter/material.dart';
import 'package:kronos/app/core/provider/buildcontext_provider.dart';
import 'package:kronos/app/core/provider/dependency_provider.dart';
import 'package:kronos/app/module/app/page/app_page.dart';
import 'package:kronos/app/module/application/controller/application_controller.dart';
import 'package:kronos/app/module/application/page/application_form_page.dart';
import 'package:kronos/app/module/application/component/application_component.dart';
import 'package:kronos/app/shared/component/skeleton_loader.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  ApplicationController controller = DependencyProvider.get();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller = BuildContextProvider.watch(context);
      await controller.init();
    });
  }

  Future<void> onClickCreateApplication() async {
    await showDialog(
      context: context,
      builder: (BuildContext _) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(24),
          title: Text('Criar aplicação'),
          content: ApplicationFormPage(application: null),
        );
      },
    );
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    var applications = controller.getApplications();
    return AppPage(
      children: [
        Text(
          'Aplicação',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 500,
          child: TextFormField(
            enabled: !controller.value.isLoading,
            onChanged: controller.onChangeFilter,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search_outlined),
              labelText: 'Pesquisar',
              hintText: '',
            ),
          ),
        ),
        FilledButton(
          onPressed: onClickCreateApplication,
          child: Text('Criar aplicação'),
        ),
        if (controller.value.isLoading)
          Wrap(
            children: List.generate(10, (int _) {
              return Padding(
                padding: const EdgeInsets.all(4),
                child: SkeletonLoader(height: 120, width: 400),
              );
            }),
          ),
        Wrap(
          children: List.generate(applications.length, (int index) {
            var item = applications.elementAt(index);
            return ApplicationComponent(
              application: item,
              controller: controller,
            );
          }),
        ),
      ],
    );
  }
}
