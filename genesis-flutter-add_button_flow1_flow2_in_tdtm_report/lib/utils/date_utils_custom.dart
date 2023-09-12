import 'package:intl/intl.dart';

class DateUtilsCustom {
  static String getCurrentFormmatedDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat("MM-dd-yyyy");
    return formatter.format(now);
  }

  static String getYesterdayFormmatedDate() {
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    final DateFormat formatter = DateFormat("MM-dd-yyyy");
    return formatter.format(yesterday);
  }

  static String getFirstDateOfMonth() {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = new DateTime(now.year, now.month, 1);
    final DateFormat formatter = DateFormat("MM-dd-yyyy");
    return formatter.format(firstDayOfMonth);
  }

  static DateTime getCurrentDateDateTime() {
    final DateTime now = DateTime.now();
    return now;
  }

  static DateTime getFirstDateOfMonthDateTime() {
    DateTime now = DateTime.now();
    DateTime firstDayDateFormate = new DateTime(now.year, now.month, 1);
    return firstDayDateFormate;
  }

  static String getSubstractedMonthDate(DateTime now, int monthsToSubstract) {
    DateTime substracted =
        DateTime(now.year, now.month - monthsToSubstract, now.day);
    return "${substracted.toLocal()}".split(' ')[0];
  }
}
