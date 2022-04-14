import 'package:intl/intl.dart';

extension DateTimeEX on DateTime {
  String get ddmmyyyy => DateFormat('dd/MM/yyyy').format(this);

  static DateTime? fromString(String dateAsString) {
    try {
      return DateFormat('dd/MM/yyyy').parse(dateAsString);
    } catch (error) {
      return null;
    }
  }
}
