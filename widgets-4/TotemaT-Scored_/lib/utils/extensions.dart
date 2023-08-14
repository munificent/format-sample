import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scored/generated/l10n.dart';

extension Snackbar on BuildContext {
  void showSnackbar(
      String title, String? actionLabel, VoidCallback? actionOnPressed) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        content: Text(title),
        action: actionLabel != null && actionOnPressed != null
            ? SnackBarAction(
                label: actionLabel.toUpperCase(),
                textColor: Theme.of(this).colorScheme.secondary,
                onPressed: actionOnPressed)
            : null));
  }
}

extension DateHelpers on DateTime {
  bool isThisYear() {
    final now = DateTime.now();
    return now.year == year;
  }

  bool isToday() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  String toReadable(S s) {
    final locale = Intl.defaultLocale;
    final time = DateFormat.jm(locale).format(this);

    if (isToday()) {
      return s.historyDate(s.today, time);
    }

    if (isYesterday()) {
      return s.historyDate(s.yesterday, time);
    }

    final formatter =
        isThisYear() ? DateFormat.MMMd(locale) : DateFormat.yMMMd(locale);
    return s.historyDate(formatter.format(this), time);
  }
}
