import 'package:flutter/material.dart';

class LogTypeConstant {
  static String success = 'SUCCESS';
  static String info = 'INOF';
  static String error = 'ERROR';

  static String translate(String input) {
    if (input == success) {
      return 'Sucesso';
    } else if (input == info) {
      return 'Informação';
    } else if (input == error) {
      return 'Erro';
    }
    return '';
  }

  static Color color(String input) {
    if (input == success) {
      return Colors.green;
    } else if (input == info) {
      return Colors.amber;
    } else if (input == error) {
      return Colors.red;
    }
    return Colors.black;
  }
}
