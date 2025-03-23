import 'package:flutter/material.dart';
import 'package:kronos/app/core/provider/buildcontext_provider.dart';
import 'package:kronos/app/module/app/component/app_drawer_custom_button_component.dart';
import 'package:kronos/app/module/app/component/app_drawer_button_component.dart';
import 'package:kronos/app/module/core/controller/theme_controller.dart';

class AppDrawerComponent extends StatefulWidget {
  const AppDrawerComponent({super.key});

  @override
  State<AppDrawerComponent> createState() => _AppDrawerComponentState();
}

class _AppDrawerComponentState extends State<AppDrawerComponent> {
  @override
  Widget build(BuildContext context) {
    ThemeController themeController = BuildContextProvider.watch(context);
    var isDarkMode = themeController.isDarkMode(context);
    return SizedBox(
      width: 260,
      child: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('Kronos', style: TextStyle(fontSize: 48, letterSpacing: 2)),
          Divider(),
          AppDrawerButtonComponent(
            title: 'Início',
            router: '/home/',
            icon: Icons.home_outlined,
          ),
          AppDrawerButtonComponent(
            title: 'Aplicação',
            router: '/application/',
            icon: Icons.apps_outlined,
          ),
          AppDrawerButtonComponent(
            title: 'HealthCheck',
            router: '/healthcheck/',
            icon: Icons.health_and_safety_outlined,
          ),
          AppDrawerButtonComponent(
            title: 'Estatística',
            router: '/statistic/',
            icon: Icons.bar_chart_rounded,
          ),
          Spacer(),
          if (isDarkMode)
            AppDrawerCustomButtonComponent(
              leading: Icons.dark_mode_outlined,
              title: 'Tema escuro',
              trailing: Icons.change_circle_outlined,
              onTap: () => themeController.change(ThemeMode.light),
            ),
          if (!isDarkMode)
            AppDrawerCustomButtonComponent(
              leading: Icons.light_mode_outlined,
              title: 'Tema claro',
              trailing: Icons.change_circle_outlined,
              onTap: () => themeController.change(ThemeMode.dark),
            ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
