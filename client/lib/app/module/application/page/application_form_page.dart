import 'package:flutter/material.dart';
import 'package:kronos/app/core/model/application/application_request.dart';
import 'package:kronos/app/core/model/application/application_response.dart';
import 'package:kronos/app/core/provider/buildcontext_provider.dart';
import 'package:kronos/app/core/provider/dependency_provider.dart';
import 'package:kronos/app/core/provider/navigator_provider.dart';
import 'package:kronos/app/core/validator/form_validator.dart';
import 'package:kronos/app/module/application/controller/application_form_controller.dart';

class ApplicationFormPage extends StatefulWidget {
  final ApplicationResponse? application;
  const ApplicationFormPage({required this.application, super.key});

  @override
  State<ApplicationFormPage> createState() => _ApplicationFormPageState();
}

class _ApplicationFormPageState extends State<ApplicationFormPage> {
  ApplicationFormController controller = DependencyProvider.get();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ApplicationRequest applicationRequest = ApplicationRequest(id: '', name: '');

  @override
  void initState() {
    applicationRequest.id = widget.application?.id ?? '';
    applicationRequest.name = widget.application?.name ?? '';
    applicationRequest.healthCheck = widget.application?.healthCheck;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller = BuildContextProvider.watch(context);
    });
  }

  Future<void> onClickCreateUpdate() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (applicationRequest.id.isEmpty) {
      await controller.create(applicationRequest);
    } else {
      await controller.update(applicationRequest);
    }
  }

  Future<void> onClickRemove() async {
    var response = await showDialog<bool?>(
      context: context,
      builder: (BuildContext _) {
        return AlertDialog(
          title: Text('Confirmar remoção'),
          content: Text(
            'Tem certeza que deseja remover essa aplicação?\nTodos os dados serão apagados também.\nEssa ação não é reversível',
          ),
          actions: [
            TextButton(
              onPressed: () => NavigatorProvider.pop(result: false),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => NavigatorProvider.pop(result: true),
              child: Text('Confirmar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (response == true) {
      await controller.delete(applicationRequest);
    }
  }

  void onChangeName(String? input) {
    applicationRequest.name = input ?? '';
  }

  void onChangeHealthCheck(String? input) {
    applicationRequest.healthCheck = input ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 20,
          children: [
            Visibility(
              visible: controller.value.isLoading,
              child: LinearProgressIndicator(),
            ),
            TextFormField(
              initialValue: applicationRequest.name,
              validator: FormValidator.requiredField,
              onChanged: onChangeName,
              enabled: !controller.value.isLoading,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.apps_outlined),
                labelText: 'Nome da aplicação',
                hintText: '',
                counterText: '',
              ),
              maxLength: 100,
            ),
            TextFormField(
              initialValue: applicationRequest.healthCheck ?? '',
              onChanged: onChangeHealthCheck,
              enabled: !controller.value.isLoading,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.health_and_safety_outlined),
                labelText: 'HealthCheck',
                hintText: '',
                counterText: '',
              ),
              maxLength: 1000,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 20,
              children: [
                Visibility(
                  visible: applicationRequest.id.isNotEmpty,
                  child: SizedBox(
                    width: 120,
                    child: FilledButton(
                      onPressed:
                          controller.value.isLoading ? null : onClickRemove,
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color?>((
                              Set<WidgetState> states,
                            ) {
                              if (states.contains(WidgetState.disabled)) {
                                return Colors.grey.shade500;
                              }
                              return Colors.red.shade800;
                            }),
                        foregroundColor: WidgetStateProperty.all<Color>(
                          Colors.white,
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: Text('Remover'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: FilledButton(
                    onPressed:
                        controller.value.isLoading ? null : onClickCreateUpdate,
                    child: Text('Salvar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
