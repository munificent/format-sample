import 'dart:io';

import 'intl_messages_tools.dart';

/// Checks an `.intl` file. Returns the file entries ([IntlRawEntry]) if OK or `null` if the check fails.
List<IntlRawEntry?>? checkIntlFile(File file,
    {String fileType = 'FILE', void Function(String type, Object? msg)? log}) {
  log ??= _log;

  try {
    var entries = readIntlEntries(file, fileType: fileType, strict: true);
    if (entries == null) {
      log('CHECK', "Can't read `intl` file: $file");
      return null;
    }

    return checkIntlEntries(entries, fileType: fileType, log: log);
  } catch (e) {
    log('CHECK', '$e');
    return null;
  }
}

/// Read the `.intl` [file] and parses its entries as [IntlRawEntry].
/// Null entries in the returned [List] represent empty lines in the file.
List<IntlRawEntry?>? readIntlEntries(File file,
    {String fileType = 'FILE', bool strict = false}) {
  _log(fileType.trim().toUpperCase(), 'Reading file: ${file.path}');

  var lines = _readLines(file);
  return IntlRawEntry.fromLines(lines);
}

List<String>? _readLines(File file) {
  if (!file.existsSync()) return null;
  var content = file.readAsStringSync();
  var lines = content.split(RegExp(r'(:?\r\n|\n)'));
  return lines;
}

void _log(String type, Object? message) {
  print('## [$type]\t$message');
}
