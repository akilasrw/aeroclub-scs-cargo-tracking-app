import 'package:intl/intl.dart';

DateTime stringToDateTime(String dateTimeStr) {
  try {
    return DateTime.parse(dateTimeStr);
  } catch (e) {
    print(e);
    return DateTime.now();
  }
}

bool isToday(DateTime date) {
  try {
    var today = DateTime.now();
    if (date.day == today.day && date.month == today.month) {
      return true;
    }
  } catch (e) {
    print(e);
    return false;
  }
  return false;
}

String dateToDayName(DateTime dateTime) {
  return DateFormat('EEE').format(dateTime);
}

String dateToDisplayFormate(DateTime dateTime) {
  return DateFormat.yMd().add_jm().format(dateTime);
}

String dateToDisplayFormateString(String dateTime) {
  return DateFormat.yMd().add_jm().format(stringToDateTime(dateTime));
}

String dateToServerFormat(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

String dateStringToServerFormat(String dateTime) {
  return DateFormat('yyyy-MM-dd').format(stringToDateTime(dateTime));
}

String dateToWeekDay(String dateTime) {
  return DateFormat('E').format(stringToDateTime(dateTime));
}

String dateToDay(String dateTime) {
  return DateFormat('d').format(stringToDateTime(dateTime));
}
