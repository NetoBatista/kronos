class NumberUtil {
  static String formatNumber(int input) {
    var inputString = input.toString();
    var result = '';

    int contador = 0;
    for (int index = inputString.length - 1; index >= 0; index--) {
      if (contador > 0 && contador % 3 == 0) {
        result = '.$result';
      }
      result = inputString[index] + result;
      contador++;
    }

    return result;
  }
}
