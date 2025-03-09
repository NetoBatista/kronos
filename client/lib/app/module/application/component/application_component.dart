import 'package:flutter/material.dart';
import 'package:kronos/app/core/model/application/application_response.dart';
import 'package:kronos/app/module/application/controller/application_controller.dart';
import 'package:kronos/app/module/application/page/application_form_page.dart';

class ApplicationComponent extends StatelessWidget {
  final ApplicationResponse application;
  final ApplicationController controller;
  const ApplicationComponent({
    required this.application,
    required this.controller,
    super.key,
  });

  String get healthCheck {
    if (application.healthCheck == null || application.healthCheck == '') {
      return '- - -';
    }
    return application.healthCheck ?? '';
  }

  Future<void> onClickApplication(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext _) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(24),
          title: Text('Atualizar aplicação'),
          content: ApplicationFormPage(application: application),
        );
      },
    );
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onClickApplication(context),
        child: SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  application.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.copy_outlined),
                    ),
                    Flexible(
                      child: Text(
                        '# ${application.key}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Text(
                  'HealthCheck: $healthCheck',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
