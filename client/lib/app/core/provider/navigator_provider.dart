import 'package:flutter_modular/flutter_modular.dart';

class NavigatorProvider {
  static void navigate(String path, {dynamic arguments}) {
    Modular.to.navigate(path, arguments: arguments);
  }

  static Future<T?> pushNamed<T>(String path, {dynamic arguments}) {
    return Modular.to.pushNamed<T>(path, arguments: arguments);
  }

  static void pop({dynamic result}) {
    Modular.to.pop(result);
  }

  static String path() => Modular.to.path;
}
