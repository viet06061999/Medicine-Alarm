// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a he locale. All the
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
  String get localeName => 'he';

  static String m0(name) => "שלום ${name}!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_name": MessageLookupByLibrary.simpleMessage("תזכורת תרופות"),
        "hello": m0,
        "i_took": MessageLookupByLibrary.simpleMessage("לקחתי את הכדור הזה"),
        "name_null": MessageLookupByLibrary.simpleMessage("נא להזין שם משתמש!"),
        "next": MessageLookupByLibrary.simpleMessage("הַבָּא"),
        "next_ball": MessageLookupByLibrary.simpleMessage("הכדור הבא"),
        "prev_ball": MessageLookupByLibrary.simpleMessage("הכדור הקודם"),
        "reminder_take":
            MessageLookupByLibrary.simpleMessage("תזכורת לקחת תרופהn!"),
        "time_left": MessageLookupByLibrary.simpleMessage("הזמן שנותר"),
        "wait_pick": MessageLookupByLibrary.simpleMessage(
            "מחכה לגלולה הראשונה של היום!"),
        "what_time": MessageLookupByLibrary.simpleMessage("מה השעה עכשיו?"),
        "youHavePushedTheButtonThisManyTimes":
            MessageLookupByLibrary.simpleMessage(
                "You have pushed the button this many times:"),
        "your_name": MessageLookupByLibrary.simpleMessage("השם שלך?")
      };
}
