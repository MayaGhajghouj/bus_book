import 'dart:core';

extension MyFormat on DateTime {
  static const Map<int, String> weekdays = {
    1: "الاثنين",
    2: 'الثلاثاء',
    3: 'الاربعاء',
    4: 'الخميس',
    5: 'الجمعة',
    6: 'السبت',
    7: 'الأحد'
  };

  String get weekDayString {
    return weekdays[weekday]!;
  }

  String get myFormat {
    return DateTime(year, month, day).toString().substring(0, 10);
  }
}
