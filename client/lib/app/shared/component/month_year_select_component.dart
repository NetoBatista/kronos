import 'package:flutter/material.dart';
import 'package:kronos/app/core/provider/navigator_provider.dart';
import 'package:kronos/app/shared/util/date_util.dart';

class MonthYearSelectDialogComponent {
  DateTime selectedDate = DateTime.now();
  int minYear = 2000;
  int currentYear = 0;
  int get maxYear {
    return DateTime.now().year + 2;
  }

  MonthYearSelectDialogComponent() {
    currentYear = DateTime.now().year;
  }

  Future<DateTime?> showMonthYearDialog({
    required BuildContext context,
    DateTime? currentDate,
    int minYear = 2000,
  }) {
    if (currentDate != null) {
      selectedDate = currentDate;
    }
    this.minYear = minYear;

    return showDialog<DateTime?>(
      context: context,
      useSafeArea: true,
      builder: (BuildContext ctx) {
        return MonthYearSelectComponent(
          months: DateUtil.getAllMonth(true),
          selectedDate: selectedDate,
          minYear: minYear,
          maxYear: maxYear,
        );
      },
    );
  }
}

class MonthYearSelectComponent extends StatefulWidget {
  final List<String> months;
  final DateTime selectedDate;
  final int minYear;
  final int maxYear;

  const MonthYearSelectComponent({
    required this.months,
    required this.selectedDate,
    required this.minYear,
    required this.maxYear,
    super.key,
  });

  @override
  State<MonthYearSelectComponent> createState() =>
      _MonthYearSelectComponentState();
}

class _MonthYearSelectComponentState extends State<MonthYearSelectComponent> {
  late int _currentYear;
  late DateTime _selectedDate = widget.selectedDate;
  List<String> get _months => widget.months;
  int get _minYear => widget.minYear;
  int get _maxYear => widget.maxYear;

  @override
  void initState() {
    _selectedDate = widget.selectedDate;
    _currentYear = _selectedDate.year;
    super.initState();
  }

  void onTapChangeMonth(int month) {
    setState(() {
      _selectedDate = DateTime(_currentYear, month, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Selecione uma data',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(width: 80, child: _buildDropDownSelectYear()),
              ],
            ),
            const SizedBox(height: 16),
            _buildMonthYear(),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: NavigatorProvider.pop,
                  child: Text('Cancelar'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    NavigatorProvider.pop(result: _selectedDate);
                  },
                  child: Text('Confirmar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropDownSelectYear() {
    return DropdownButton<int>(
      isExpanded: true,
      menuMaxHeight: 260,
      value: _currentYear,
      onChanged: (int? newValue) {
        if (newValue == null) {
          return;
        }
        setState(() {
          _currentYear = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return _generateYear(_minYear).map<Widget>((int year) {
          return Container(
            alignment: Alignment.center,
            child: Text(year.toString()),
          );
        }).toList();
      },
      items:
          _generateYear(_minYear).map<DropdownMenuItem<int>>((int year) {
            var isSelected = _currentYear == year;
            return DropdownMenuItem<int>(
              value: year,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  year.toString(),
                  style: TextStyle(
                    color: !isSelected ? null : Colors.blue.shade800,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  List<int> _generateYear(int minYear) {
    List<int> response = [];
    for (int year = _maxYear; year > minYear; year--) {
      response.add(year);
    }
    return response;
  }

  Widget _buildMonthYear() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              _months.sublist(0, 4).map((month) {
                return buildItemMonth(month);
              }).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              _months.sublist(4, 8).map((month) {
                return buildItemMonth(month);
              }).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              _months.sublist(8, 12).map((month) {
                return buildItemMonth(month);
              }).toList(),
        ),
      ],
    );
  }

  Widget buildItemMonth(String month) {
    var indexMonth = _months.indexOf(month) + 1;
    var sameMonth = indexMonth == _selectedDate.month;
    var sameYear = _currentYear == _selectedDate.year;
    var isSelected = sameMonth && sameYear;

    if (isSelected) {
      return Card(
        color: Colors.blue.shade800,
        child: InkWell(
          onTap: () {
            onTapChangeMonth(indexMonth);
          },
          child: Container(
            width: 64,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            child: Text(
              month,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      );
    }

    return Card(
      child: InkWell(
        onTap: () {
          onTapChangeMonth(indexMonth);
        },
        child: Container(
          width: 64,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          child: Text(month, style: const TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
