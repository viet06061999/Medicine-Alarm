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

  static String m3(time, med) => "It\'s time: ${time} to take medicine ${med}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_pill": MessageLookupByLibrary.simpleMessage("Add Pill"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "app_name": MessageLookupByLibrary.simpleMessage("Medicine Alarm"),
        "bedtime_before_content": MessageLookupByLibrary.simpleMessage(
            "Do you want to edit settings?"),
        "bedtime_before_next_content": MessageLookupByLibrary.simpleMessage(
            "Do you want an alarm next pill?"),
        "bedtime_before_next_title": MessageLookupByLibrary.simpleMessage(
            "The next pill is after bedtime!"),
        "bedtime_before_title": MessageLookupByLibrary.simpleMessage(
            "The last pill is after bedtime!"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cancel_last":
            MessageLookupByLibrary.simpleMessage("Cancel the last take pill?"),
        "content_noti": MessageLookupByLibrary.simpleMessage(
            "Don\'t forget to mark it as \"I took this pill\""),
        "count_option": m0,
        "create_new": MessageLookupByLibrary.simpleMessage(
            "Create a new medicine alarm!"),
        "day_of_week": MessageLookupByLibrary.simpleMessage("Day of the week"),
        "delete_medicine": MessageLookupByLibrary.simpleMessage(
            "Do you want to delete this medicine alarm?"),
        "delete_medicine_title":
            MessageLookupByLibrary.simpleMessage("Delete the medicine alarm!"),
        "describe": MessageLookupByLibrary.simpleMessage("Describe"),
        "dont_take": MessageLookupByLibrary.simpleMessage(
            "You don\'t need to take this pill today!"),
        "duration_pill":
            MessageLookupByLibrary.simpleMessage("Duration take pill"),
        "edit_pill": MessageLookupByLibrary.simpleMessage("Edit Pill"),
        "error_interval": MessageLookupByLibrary.simpleMessage(
            "Please select the reminder\'s number"),
        "error_name_duplicate": MessageLookupByLibrary.simpleMessage(
            "Medicine name already exists"),
        "error_name_null": MessageLookupByLibrary.simpleMessage(
            "Please enter the medicine\'s name"),
        "error_valid_start_time": MessageLookupByLibrary.simpleMessage(
            "Bed time can\'t less than start time"),
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
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "no_alarm": MessageLookupByLibrary.simpleMessage(
            "You don\'t have a medicine alarm!"),
        "number": MessageLookupByLibrary.simpleMessage("Number take pill"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "prev_ball": MessageLookupByLibrary.simpleMessage("The previous ball"),
        "reminder_take":
            MessageLookupByLibrary.simpleMessage("Reminder to take medicine!"),
        "same_start": MessageLookupByLibrary.simpleMessage(
            "You have another pill same start time"),
        "sat": MessageLookupByLibrary.simpleMessage("Sat"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "start_time": MessageLookupByLibrary.simpleMessage("Start time"),
        "sun": MessageLookupByLibrary.simpleMessage("Sun"),
        "take_time": MessageLookupByLibrary.simpleMessage("When take pill?"),
        "thu": MessageLookupByLibrary.simpleMessage("Thu"),
        "time_bed": MessageLookupByLibrary.simpleMessage("Bed time"),
        "time_left": MessageLookupByLibrary.simpleMessage("Time left"),
        "title_noti": m3,
        "tue": MessageLookupByLibrary.simpleMessage("Tue"),
        "wait_pick": MessageLookupByLibrary.simpleMessage(
            "Waiting for the first pill of the day!"),
        "wait_tomorrow": MessageLookupByLibrary.simpleMessage(
            "Waiting for the first pill of tomorrow!"),
        "want_change": MessageLookupByLibrary.simpleMessage(
            "Do you want to change the start time?"),
        "wed": MessageLookupByLibrary.simpleMessage("Wed"),
        "what_time": MessageLookupByLibrary.simpleMessage("What is time now?"),
        "when_did":
            MessageLookupByLibrary.simpleMessage("When did I take today?"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "your_name": MessageLookupByLibrary.simpleMessage("Your name?")
      };
}
