import 'package:test/test.dart';

import 'package:ruby_date_time/ruby_date_time.dart';

void main() {
  DateTime dateTime = DateTime(2019, 12, 11, 1, 23, 45);

  group('Change a date time', () {
    test('without reset time', () {
      DateTime actualDateTime = dateTime.change(
        year: 2018,
        month: 11,
        day: 10,
        hour: 23,
        minute: 45,
        second: 1
      );
      DateTime matcherDateTime = DateTime(2018, 11, 10, 23, 45, 1);

      expect(actualDateTime, matcherDateTime);
    });

    test('with reset time', () {
      DateTime actualDateTime = dateTime.change(year: 2018, month: 11, day: 10, resetTime: true);

      expect(actualDateTime, DateTime(2018, 11, 10, 0, 0, 0));
    });
  });
  group('Start of', () {
    test('minute', () {
      expect(dateTime.startOfMinute(), DateTime(2019, 12, 11, 1, 23));
    });

    test('hour', () {
      expect(dateTime.startOfHour(), DateTime(2019, 12, 11, 1));
    });

    test('day', () {
      expect(dateTime.startOfDay(), DateTime(2019, 12, 11));
    });

    test('week', () {
      expect(dateTime.startOfWeek(), DateTime(2019, 12, 9));
    });

    test('month', () {
      expect(dateTime.startOfMonth(), DateTime(2019, 12, 1));
    });

    test('quarter', () {
      expect(dateTime.startOfQuarter(), DateTime(2019, 10, 1));
    });

    test('year', () {
      expect(dateTime.startOfYear(), DateTime(2019, 1, 1));
    });
  });

  group('End of', () {
    final DateTime endOfYearDateTime = DateTime(2019, 12, 31, 23, 59, 59);

    test('minute', () {
      expect(dateTime.endOfMinute(), DateTime(2019, 12, 11, 1, 23, 59));
    });

    test('hour', () {
      expect(dateTime.endOfHour(), DateTime(2019, 12, 11, 1, 59, 59));
    });

    test('day', () {
      expect(dateTime.endOfDay(), DateTime(2019, 12, 11, 23, 59, 59));
    });

    test('week', () {
      expect(dateTime.endOfWeek(), DateTime(2019, 12, 15, 23, 59, 59));
    });

    test('month', () {
      expect(dateTime.endOfMonth(), endOfYearDateTime);
    });

    test('quarter', () {
      expect(dateTime.endOfQuarter(), endOfYearDateTime);
    });

    test('year', () {
      expect(dateTime.endOfYear(), endOfYearDateTime);
    });
  });
}
