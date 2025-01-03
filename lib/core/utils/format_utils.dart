import 'package:intl/intl.dart';

String formatNumber(String value) {
  String cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
  if (cleanedValue.isEmpty) return '';

  int number = int.parse(cleanedValue);
  return NumberFormat('#,###').format(number);
}
