// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) => "${count} times";

  static String m1(name) => "Hello ${name}!";

  static String m2(hour) => "${hour} hours";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "app_name": MessageLookupByLibrary.simpleMessage("Medicine Alarm"),
        "count_option": m0,
        "day_of_week": MessageLookupByLibrary.simpleMessage("Day of the week"),
        "describe": MessageLookupByLibrary.simpleMessage("Describe"),
        "duration_pill":
            MessageLookupByLibrary.simpleMessage("Duration take pill"),
        "fri": MessageLookupByLibrary.simpleMessage("Fri"),
        "hello": m1,
        "hour_option": m2,
        "i_took": MessageLookupByLibrary.simpleMessage("I took this pill"),
        "list_pill": MessageLookupByLibrary.simpleMessage("List off pill"),
        "mon": MessageLookupByLibrary.simpleMessage("Mon"),
        "name_null":
            MessageLookupByLibrary.simpleMessage("Please enter user name!"),
        "name_pill": MessageLookupByLibrary.simpleMessage("Name off pill"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "next_ball": MessageLookupByLibrary.simpleMessage("The next ball"),
        "number": MessageLookupByLibrary.simpleMessage("Number take pill"),
        "prev_ball": MessageLookupByLibrary.simpleMessage("The previous ball"),
        "reminder_take":
            MessageLookupByLibrary.simpleMessage("Reminder to take medicine!"),
        "sat": MessageLookupByLibrary.simpleMessage("Sat"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "start_time": MessageLookupByLibrary.simpleMessage("Start time"),
        "sun": MessageLookupByLibrary.simpleMessage("Sun"),
        "thu": MessageLookupByLibrary.simpleMessage("Thu"),
        "time_bed": MessageLookupByLibrary.simpleMessage("Bed time"),
        "time_left": MessageLookupByLibrary.simpleMessage("Time left"),
        "tue": MessageLookupByLibrary.simpleMessage("Tue"),
        "wait_pick": MessageLookupByLibrary.simpleMessage(
            "Waiting for the first pill of the day!"),
        "wed": MessageLookupByLibrary.simpleMessage("Wed"),
        "what_time": MessageLookupByLibrary.simpleMessage("What is time now?"),
        "when_did":
            MessageLookupByLibrary.simpleMessage("When did I take today?"),
        "your_name": MessageLookupByLibrary.simpleMessage("Your name?")
      };
}
