import 'package:flutter/material.dart';
import 'package:kronos/app/core/constant/local_storage_constant.dart';
import 'package:kronos/app/core/constant/theme_mode_constant.dart';
import 'package:kronos/app/core/interface/ilocal_storage_service.dart';

class ThemeController extends ValueNotifier<ThemeMode> {
  final ILocalStorageService _localStorageService;
  ThemeController(this._localStorageService) : super(ThemeMode.system);

  Future<void> load() async {
    var themeMode = await _localStorageService.getString(
      LocalStorageConstant.themeMode,
    );
    if (themeMode == ThemeModeConstant.light) {
      value = ThemeMode.light;
    } else if (themeMode == ThemeModeConstant.dark) {
      value = ThemeMode.dark;
    } else {
      value = ThemeMode.system;
    }
    notifyListeners();
  }

  Future<void> change(ThemeMode newTheme) async {
    var mode = ThemeModeConstant.system;
    if (newTheme == ThemeMode.light) {
      mode = ThemeModeConstant.light;
    } else if (newTheme == ThemeMode.dark) {
      mode = ThemeModeConstant.dark;
    }
    await _localStorageService.setString(LocalStorageConstant.themeMode, mode);
    await load();
  }

  bool isDarkMode(BuildContext context) {
    if (value == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }

    return value == ThemeMode.dark;
  }
}
