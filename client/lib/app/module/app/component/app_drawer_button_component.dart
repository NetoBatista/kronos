import 'package:flutter/material.dart';
import 'package:kronos/app/core/provider/dependency_provider.dart';
import 'package:kronos/app/core/provider/navigator_provider.dart';
import 'package:kronos/app/module/app/controller/app_controller.dart';
import 'package:kronos/app/shared/state/state_shared.dart';

class AppDrawerButtonComponent extends StatelessWidget {
  final String title;
  final String router;
  final IconData icon;
  const AppDrawerButtonComponent({
    required this.title,
    required this.router,
    required this.icon,
    super.key,
  });

  bool isSelected() {
    return NavigatorProvider.path().startsWith(router);
  }

  void onTap() {
    NavigatorProvider.navigate(router);
    AppController controller = DependencyProvider.get();
    controller.value = StateSharedState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListTile(
        tileColor: isSelected() ? Colors.blue.shade800 : null,
        textColor: isSelected() ? Colors.white : null,
        iconColor: isSelected() ? Colors.white : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onTap: onTap,
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
