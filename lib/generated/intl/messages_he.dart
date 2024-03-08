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

  static String m3(med) => "הגיע הזמן לקחת תרופה ${med}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_pill": MessageLookupByLibrary.simpleMessage("הוסף גלולה"),
        "all": MessageLookupByLibrary.simpleMessage("את כל"),
        "app_name": MessageLookupByLibrary.simpleMessage("תזכורת תרופות"),
        "bedtime_before_content":
            MessageLookupByLibrary.simpleMessage("האם אתה רוצה לערוך הגדרות?"),
        "bedtime_before_next_content": MessageLookupByLibrary.simpleMessage(
            "האם אתה רוצה אזעקה הגלולה הבאה?"),
        "bedtime_before_next_title":
            MessageLookupByLibrary.simpleMessage("הגלולה הבאה היא אחרי השינה!"),
        "bedtime_before_title": MessageLookupByLibrary.simpleMessage(
            "הגלולה האחרונה היא אחרי השינה!"),
        "cancel": MessageLookupByLibrary.simpleMessage("לְבַטֵל"),
        "cancel_last":
            MessageLookupByLibrary.simpleMessage("לבטל את הגלולה האחרונה?"),
        "content_noti": MessageLookupByLibrary.simpleMessage(
            "אל תשכח לסמן את זה כ\"לקחתי את הגלולה הזו\""),
        "count_option": m0,
        "create_new":
            MessageLookupByLibrary.simpleMessage("צור אזעקת תרופות חדשה!"),
        "day_of_week": MessageLookupByLibrary.simpleMessage("יום בשבוע"),
        "delete_medicine": MessageLookupByLibrary.simpleMessage(
            "האם אתה רוצה למחוק את אזעקת התרופה הזו?"),
        "delete_medicine_title":
            MessageLookupByLibrary.simpleMessage("מחק את אזעקת התרופות!"),
        "describe": MessageLookupByLibrary.simpleMessage("לְתַאֵר"),
        "dont_take": MessageLookupByLibrary.simpleMessage(
            "אתה לא צריך לקחת את הגלולה הזו היום!"),
        "duration_pill": MessageLookupByLibrary.simpleMessage("משך לקחת גלולה"),
        "edit_pill": MessageLookupByLibrary.simpleMessage("ערוך גלולה"),
        "error_interval":
            MessageLookupByLibrary.simpleMessage("אנא בחר את מספר התזכורת"),
        "error_name_duplicate":
            MessageLookupByLibrary.simpleMessage("שם התרופה כבר קיים"),
        "error_name_null":
            MessageLookupByLibrary.simpleMessage("נא להזין את שם התרופה"),
        "error_valid_start_time": MessageLookupByLibrary.simpleMessage(
            "זמן השינה לא יכול להיות פחות משעת ההתחלה"),
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
        "no": MessageLookupByLibrary.simpleMessage("לא"),
        "no_alarm":
            MessageLookupByLibrary.simpleMessage("אין לך אזעקת תרופות!"),
        "number": MessageLookupByLibrary.simpleMessage("מספר לקחת גלולה"),
        "ok": MessageLookupByLibrary.simpleMessage("בסדר"),
        "prev_ball": MessageLookupByLibrary.simpleMessage("הכדור הקודם"),
        "remind": MessageLookupByLibrary.simpleMessage("תזכיר לי בעוד 10 דקות"),
        "remind_later":
            MessageLookupByLibrary.simpleMessage("תזכיר מאוחר יותר"),
        "reminder_take":
            MessageLookupByLibrary.simpleMessage("תזכורת לקחת תרופה!"),
        "same_start": MessageLookupByLibrary.simpleMessage(
            "יש לך עוד גלולה באותו זמן התחלה"),
        "sat": MessageLookupByLibrary.simpleMessage("ום ש"),
        "settings": MessageLookupByLibrary.simpleMessage("הגדרות"),
        "start_time": MessageLookupByLibrary.simpleMessage("שעת התחלה"),
        "sun": MessageLookupByLibrary.simpleMessage("ום א"),
        "take_time": MessageLookupByLibrary.simpleMessage("מתי לקחת גלולה?"),
        "thu": MessageLookupByLibrary.simpleMessage("ום ה"),
        "time_bed": MessageLookupByLibrary.simpleMessage("זמן השינה"),
        "time_left": MessageLookupByLibrary.simpleMessage("הזמן שנותר"),
        "title_noti": m3,
        "tue": MessageLookupByLibrary.simpleMessage("ום ג"),
        "wait_pick": MessageLookupByLibrary.simpleMessage(
            "מחכה לגלולה הראשונה של היום!"),
        "wait_tomorrow":
            MessageLookupByLibrary.simpleMessage("מחכה לגלולה הראשונה של מחר!"),
        "want_change": MessageLookupByLibrary.simpleMessage(
            "האם ברצונך לשנות את שעת ההתחלה?"),
        "wed": MessageLookupByLibrary.simpleMessage("ום ד"),
        "what_time": MessageLookupByLibrary.simpleMessage("מה השעה עכשיו?"),
        "when_did": MessageLookupByLibrary.simpleMessage("מתי לקחתי היום?"),
        "yes": MessageLookupByLibrary.simpleMessage("כן"),
        "your_name": MessageLookupByLibrary.simpleMessage("השם שלך?")
      };
}
