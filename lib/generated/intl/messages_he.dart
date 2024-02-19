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

  static String m0(count) => "${count} פעמים";

  static String m1(name) => "שלום ${name}!";

  static String m2(hour) => "${hour} שעות";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "all": MessageLookupByLibrary.simpleMessage("את כל"),
        "app_name": MessageLookupByLibrary.simpleMessage("תזכורת תרופות"),
        "count_option": m0,
        "day_of_week": MessageLookupByLibrary.simpleMessage("יום בשבוע"),
        "describe": MessageLookupByLibrary.simpleMessage("לְתַאֵר"),
        "duration_pill": MessageLookupByLibrary.simpleMessage("משך לקחת גלולה"),
        "fri": MessageLookupByLibrary.simpleMessage("ום ו"),
        "hello": m1,
        "hour_option": m2,
        "i_took": MessageLookupByLibrary.simpleMessage("לקחתי את הכדור הזה"),
        "list_pill": MessageLookupByLibrary.simpleMessage("רשימת הגלולה"),
        "mon": MessageLookupByLibrary.simpleMessage("ום ב"),
        "name_null": MessageLookupByLibrary.simpleMessage("נא להזין שם משתמש!"),
        "name_pill": MessageLookupByLibrary.simpleMessage("שם הגלולה"),
        "next": MessageLookupByLibrary.simpleMessage("הַבָּא"),
        "next_ball": MessageLookupByLibrary.simpleMessage("הכדור הבא"),
        "number": MessageLookupByLibrary.simpleMessage("מספר לקחת גלולה"),
        "prev_ball": MessageLookupByLibrary.simpleMessage("הכדור הקודם"),
        "reminder_take":
            MessageLookupByLibrary.simpleMessage("תזכורת לקחת תרופהn!"),
        "sat": MessageLookupByLibrary.simpleMessage("ום ש"),
        "settings": MessageLookupByLibrary.simpleMessage("הגדרות"),
        "start_time": MessageLookupByLibrary.simpleMessage("שעת התחלה"),
        "sun": MessageLookupByLibrary.simpleMessage("ום א"),
        "thu": MessageLookupByLibrary.simpleMessage("ום ה"),
        "time_bed": MessageLookupByLibrary.simpleMessage("זמן השינה"),
        "time_left": MessageLookupByLibrary.simpleMessage("הזמן שנותר"),
        "tue": MessageLookupByLibrary.simpleMessage("ום ג"),
        "wait_pick": MessageLookupByLibrary.simpleMessage(
            "מחכה לגלולה הראשונה של היום!"),
        "wed": MessageLookupByLibrary.simpleMessage("ום ד"),
        "what_time": MessageLookupByLibrary.simpleMessage("מה השעה עכשיו?"),
        "when_did": MessageLookupByLibrary.simpleMessage("מתי לקחתי היום?"),
        "your_name": MessageLookupByLibrary.simpleMessage("השם שלך?")
      };
}
