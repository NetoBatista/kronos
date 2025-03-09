class DateUtil {
  static final List<String> _months = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro",
  ];

  static List<String> getAllMonth(bool compact) {
    if (compact) {
      return _months.map((item) => item.substring(0, 3)).toList();
    }
    return _months;
  }

  static String getMonth(int index) => _months.elementAt(index);

  static String formatDateToRequest(DateTime input) {
    input = input.toLocal();
    return "${input.year}-${input.month}-${input.day}";
  }

  static String formatDate(DateTime input) {
    input = input.toLocal();
    var day = input.day.toString().padLeft(2, '0');
    var month = input.month.toString().padLeft(2, '0');
    var year = input.year.toString().padLeft(2, '0');
    return "$day/$month/$year";
  }

  static String formatDateTime(String input) {
    input = convertStringToLocalDate(input).toIso8601String();
    var splitted = input.split('T');
    var date = splitted[0].split('-');
    var time = splitted[1].split('.')[0];

    var year = date[0];
    var month = date[1].padLeft(2, '0');
    var day = date[2].padLeft(2, '0');

    return '$day/$month/$year $time';
  }

  static DateTime convertStringToLocalDate(String input) {
    return DateTime.parse(input).toLocal();
  }
}
