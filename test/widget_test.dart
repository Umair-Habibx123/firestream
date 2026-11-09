import 'package:flutter_test/flutter_test.dart';

import 'package:chat_app/features/utils/chat_time_format.dart';

void main() {
  // A fixed "now": Wednesday 12 November 2025, 08:00.
  final now = DateTime(2025, 11, 12, 8, 0);

  group('formatChatListTime', () {
    test('empty for a missing time', () {
      expect(formatChatListTime(null, now: now), '');
    });

    test('today shows the time with zero-padded minutes', () {
      expect(formatChatListTime(DateTime(2025, 11, 12, 7, 5), now: now), '7:05');
    });

    test('yesterday late evening is "Yesterday", even if under 24 hours ago', () {
      expect(formatChatListTime(DateTime(2025, 11, 11, 23, 0), now: now), 'Yesterday');
    });

    test('two evenings ago is a weekday, not "Yesterday"', () {
      // Monday 10 Nov, 22:00: less than 48 hours ago, but two calendar days.
      expect(formatChatListTime(DateTime(2025, 11, 10, 22, 0), now: now), 'Mon');
    });

    test('within the last week shows the weekday', () {
      expect(formatChatListTime(DateTime(2025, 11, 7, 12, 0), now: now), 'Fri');
    });

    test('a week or more ago shows day/month', () {
      expect(formatChatListTime(DateTime(2025, 11, 5, 12, 0), now: now), '5/11');
      expect(formatChatListTime(DateTime(2024, 12, 31, 12, 0), now: now), '31/12');
    });
  });
}
