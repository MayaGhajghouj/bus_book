extension MyFormate on DateTime {
  static const Map<int, String> weekdays = {
    1: "الاثنين",
    2: "الثلاثاء",
    3: "الاربعاء",
    4: "الخميس",
    5: "الجمعة",
    6: "السبت",
    7: "الأحد"
  };
  String get weekDaystring {
    return weekdays[weekday]!;
  }

  String get myFormate {
    return DateTime(year, month, day).toString().substring(0, 10);
  }
}
