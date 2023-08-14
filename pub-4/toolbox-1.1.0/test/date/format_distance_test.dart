import 'package:test/test.dart';
import 'package:toolbox/toolbox.dart';

void main() {
  group('formatDistance', () {
    test('should format seconds correctly', () {
      final DateTime date = DateTime.now().subtract(
        const Duration(seconds: 10),
      );
      final String formatted = formatDistance(
        date,
        locale: 'en',
        suffix: 'ago',
      );
      expect(formatted, '10s ago');
    });

    test('should format minutes correctly', () {
      final DateTime date = DateTime.now().subtract(const Duration(minutes: 5));
      final String formatted = formatDistance(
        date,
        locale: 'en',
        suffix: 'ago',
      );
      expect(formatted, '5m ago');
    });

    test('should format hours correctly', () {
      final DateTime date = DateTime.now().subtract(const Duration(hours: 2));
      final String formatted = formatDistance(
        date,
        locale: 'en',
        suffix: 'ago',
      );
      expect(formatted, '2h ago');
    });

    test('should format days correctly', () {
      final DateTime date = DateTime.now().subtract(const Duration(days: 3));
      final String formatted = formatDistance(
        date,
        locale: 'en',
        suffix: 'ago',
      );
      expect(formatted, '3d ago');
    });

    test('should format months correctly', () {
      final DateTime date = DateTime.now().subtract(const Duration(days: 90));
      final String formatted = formatDistance(
        date,
        locale: 'en',
        suffix: 'ago',
      );
      expect(formatted, '3m ago');
    });

    test('should format years correctly', () {
      final DateTime date = DateTime.now().subtract(const Duration(days: 400));
      final String formatted = formatDistance(
        date,
        locale: 'en',
        suffix: 'ago',
      );
      expect(formatted, '1y ago');
    });

    test('should append suffix correctly', () {
      final DateTime date = DateTime.now().subtract(const Duration(days: 1));
      final String formatted = formatDistance(
        date,
        suffix: 'until',
        locale: 'en',
      );
      expect(formatted, '1d until');
    });
  });
}
