import 'package:intl/intl.dart';

// String formatNumber(String value) {
//   String cleanedValue = value.replaceAll(RegExp(r'[^0-9].'), '');
//   if (cleanedValue.isEmpty) return '';

//   int number = int.parse(cleanedValue);
//   return NumberFormat('#,###').format(number);
// }
String formatNumber(String value, {int decimalPlaces = 3}) {
  // Remove all non-digit and non-decimal characters
  String cleanedValue = value.replaceAll(RegExp(r'[^0-9.]'), '');
  if (cleanedValue.isEmpty) return '';

  // Split the value into integer and decimal parts
  List<String> parts = cleanedValue.split('.');
  String integerPart = parts[0];
  String decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

  // Limit the number of decimal places
  if (decimalPart.length > decimalPlaces + 1) {
    decimalPart = decimalPart.substring(0, decimalPlaces + 1);
  }

  // Parse the integer part
  int? number = int.tryParse(integerPart);
  if (number == null) return '';

  // Format the integer part with commas
  String formattedInteger = NumberFormat('#,###').format(number);

  // Combine the formatted integer part and the decimal part
  return formattedInteger + decimalPart;
}
