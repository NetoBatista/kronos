import 'package:flutter_modular/flutter_modular.dart';

class DependencyProvider {
  static B get<B extends Object>() {
    return Modular.get<B>();
  }

  static bool dispose<B extends Object>() {
    return Modular.dispose<B>();
  }
}
