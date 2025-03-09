import 'package:flutter/material.dart';
import 'package:kronos/app/core/provider/buildcontext_provider.dart';
import 'package:kronos/app/core/provider/dependency_provider.dart';
import 'package:kronos/app/module/app/controller/app_controller.dart';
import 'package:kronos/app/module/app/component/app_drawer_component.dart';
import 'package:kronos/app/shared/component/default_body_component.dart';

class AppPage extends StatefulWidget {
  final List<Widget> children;
  const AppPage({required this.children, super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  AppController controller = DependencyProvider.get();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: AppDrawerComponent(),
          ),
          Expanded(child: DefaultBodyComponent(children: widget.children)),
        ],
      ),
    );
  }
}
