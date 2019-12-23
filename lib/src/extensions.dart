extension RubyDateTime on DateTime {
  static const int monthsPerQuarter = 3;

  /// Returns a new DateTime where one or more of the elements have been changed according to the options parameter.
  ///
  /// Default, time will be keep original (in case you don't passed `hour:`, `minute:` and `second:`).
  ///
  /// If you pass `resetTime: true`, The time options (`hour:`, `minute:`, `second:`) reset cascadingly,
  /// so if only the hour is passed, then minute and second is set to 0.
  /// If the hour and minute is passed, then second is set to 0
  ///
  /// The parameters takes any of these: `year:`, `month:`, `day:`, `hour:`, `minute:`, `second:`
  ///
  /// ```dart
  /// DateTime(2019, 1, 1).change(day: 2); // => 2019-01-02 00:00:00.000
  /// DateTime(2019, 1, 1, 0, 23, 45).change(year: 2020, hour: 1); // => 2020-01-01 01:23:45.000
  /// DateTime dateTime = DateTime(2019, 1, 1, 1, 23, 45); // => 2019-01-01 01:23:45.000
  /// DateTime(2019, 1, 1, 0, 23, 45).change(year: 2020, hour: 1, resetTime: true); // => 2020-01-01 01:00:00.000
  /// ```
  DateTime change({int year, int month, int day, int hour, int minute, int second, bool resetTime: false}) {
    year ??= this.year;
    month ??= this.month;
    day ??= this.day;
    hour ??= resetTime ? 0 : this.hour;
    minute ??= resetTime ? 0 : this.minute;
    second ??= resetTime ? 0 : this.second;

    return DateTime(year, month, day, hour, minute, second);
  }

  /// Returns a new `DateTime` representing the start of the minute (hh:mm:00).
  DateTime startOfMinute() => this.change(second: 0);

  /// Returns a new `DateTime` representing the start of the hour (hh:00:00).
  DateTime startOfHour() => this.change(minute: 0).startOfMinute();

  /// Returns a new `DateTime` representing the start of the day (00:00:00).
  DateTime startOfDay() => this.change(resetTime: true);

  /// Returns a new date/time representing the start of this week
  ///
  /// Week is assumed to start on Monday
  ///
  /// `DateTime` objects have their time set to 00:00:00.
  DateTime startOfWeek() {
    final int prevWeekDay = (this.weekday - 1);

    return this.subtract(Duration(days: prevWeekDay)).startOfDay();
  }

  /// Returns a new date/time at the start of the month
  /// ```dart
  /// DateTime today = DateTime.now(); // => 2019-12-18 13:20:30.649
  /// today.beginning_of_month(); // => 2019-12-01 00:00:00.000
  /// ```
  /// `DateTime` objects will have a time set to 00:00
  DateTime startOfMonth() => this.change(day: 1).startOfDay();

  /// Returns a new date/time at the start of the quarter.
  /// ```dart
  /// DateTime today = DateTime.now(); // => 2019-12-18 13:20:30.649
  /// today.beginningOfQuarter(); // => 2019-10-01 00:00:00.000
  /// ```
  /// `DateTime` objects will have a time set to 00:00
  DateTime startOfQuarter() {
    final int currentQuarter = ((this.month - 1) ~/ monthsPerQuarter);
    final int monthOfQuarter = (currentQuarter * monthsPerQuarter) + 1;

    return this.change(month: monthOfQuarter).startOfMonth();
  }

  /// Returns a new date/time at the beginning of the year.
  /// ```dart
  /// DateTime today = DateTime.now(); // => 2019-12-18 13:20:30.649
  /// today.beginningOfYear(); // => 2019-01-01 00:00:00.000
  /// ```
  /// DateTime objects will have a time set to 00:00
  DateTime startOfYear() => this.change(month: 1).startOfMonth();

  /// Returns a new `DateTime` representing the end of the minute (hh:mm:59).
  DateTime endOfMinute() => this.change(second: 59);

  /// Returns a new `DateTime` representing the end of the hour (hh:59:59).
  DateTime endOfHour() => this.change(minute: 59).endOfMinute();

  /// Returns a new `DateTime` representing the end of the day (23:59:59).
  DateTime endOfDay() => this.change(hour: 23).endOfHour();

  /// Returns a new date/time representing the end of this week on the given day.
  ///
  /// Week is assumed to start on Monday.
  ///
  /// `DateTime` objects have their time set to 23:59:59.
  DateTime endOfWeek() {
    final int startDayOfWeek = this.startOfWeek().day;
    final int daysPerWeekWithoutCurrent = (DateTime.daysPerWeek - 1);
    final int endOfWeekDays = (startDayOfWeek + daysPerWeekWithoutCurrent);

    return this.change(day: endOfWeekDays).endOfDay();
  }

  /// Returns a new date/time representing the end of the month.
  /// `DateTime` objects will have a time set to 23:59:59.
  DateTime endOfMonth() {
    final int nextMonth = (this.month + 1);

    return this.change(month: nextMonth, day: 0).endOfDay();
  }

  /// Returns a new date/time at the end of the quarter.
  /// ```dart
  /// DateTime today = DateTime.now(); // => 2019-12-18 13:20:30.649
  /// today.endOfQuarter(); // => 2019-12-31 23:59:59.000
  /// ```
  /// `DateTime` objects will have a time set to 23:59:59.
  DateTime endOfQuarter() {
    final int startMonthOfQuarter = (this.startOfQuarter().month);
    final int endMonthOfQuarter = startMonthOfQuarter + monthsPerQuarter;

    return this.change(month: endMonthOfQuarter, day: 0).endOfDay();
  }

  /// Returns a new date/time representing the end of the year.
  ///
  /// DateTime objects will have a time set to 23:59:59.
  DateTime endOfYear() => this.change(month: 12).endOfMonth();
}
