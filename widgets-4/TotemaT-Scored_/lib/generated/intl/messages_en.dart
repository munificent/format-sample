// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) => "Deleted ${count} parties";

  static String m1(name) => "Deleted ${name}";

  static String m2(date, time) => "${date} ${time}";

  static String m3(count) =>
      "${Intl.plural(count, one: '1 party selected', other: '${count} parties selected')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "continueParty": MessageLookupByLibrary.simpleMessage("Continue"),
        "createParty": MessageLookupByLibrary.simpleMessage("Create the party"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deletedParties": m0,
        "deletedParty": m1,
        "historyDate": m2,
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "noHistoryBody1":
            MessageLookupByLibrary.simpleMessage("Click on the button"),
        "noHistoryBody2":
            MessageLookupByLibrary.simpleMessage("and start a new party now!"),
        "noHistoryTitle":
            MessageLookupByLibrary.simpleMessage("No history found :("),
        "noNameError": MessageLookupByLibrary.simpleMessage("Name is required"),
        "notFoundBody": MessageLookupByLibrary.simpleMessage(
            "This page doesn\'t exist maybe you want to"),
        "notFoundButton": MessageLookupByLibrary.simpleMessage("Go back home"),
        "partyName": MessageLookupByLibrary.simpleMessage("Party Name"),
        "playerCount":
            MessageLookupByLibrary.simpleMessage("Number of players"),
        "playerName": MessageLookupByLibrary.simpleMessage("Name"),
        "playerScore": MessageLookupByLibrary.simpleMessage("Score"),
        "restart": MessageLookupByLibrary.simpleMessage(" Restart"),
        "selectColor":
            MessageLookupByLibrary.simpleMessage("Select a main color"),
        "selectColorShade":
            MessageLookupByLibrary.simpleMessage("Select a color shade"),
        "selectedParties": m3,
        "start": MessageLookupByLibrary.simpleMessage("Start"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "undo": MessageLookupByLibrary.simpleMessage("Undo"),
        "viewScores": MessageLookupByLibrary.simpleMessage("View Scores"),
        "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday")
      };
}
