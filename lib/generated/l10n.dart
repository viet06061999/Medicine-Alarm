// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Medicine Alarm`
  String get app_name {
    return Intl.message(
      'Medicine Alarm',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Reminder to take medicine!`
  String get reminder_take {
    return Intl.message(
      'Reminder to take medicine!',
      name: 'reminder_take',
      desc: '',
      args: [],
    );
  }

  /// `Your name?`
  String get your_name {
    return Intl.message(
      'Your name?',
      name: 'your_name',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Please enter user name!`
  String get name_null {
    return Intl.message(
      'Please enter user name!',
      name: 'name_null',
      desc: '',
      args: [],
    );
  }

  /// `Hello {name}!`
  String hello(String name) {
    return Intl.message(
      'Hello $name!',
      name: 'hello',
      desc: '',
      args: [name],
    );
  }

  /// `What is time now?`
  String get what_time {
    return Intl.message(
      'What is time now?',
      name: 'what_time',
      desc: '',
      args: [],
    );
  }

  /// `I took this pill`
  String get i_took {
    return Intl.message(
      'I took this pill',
      name: 'i_took',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for the first pill of the day!`
  String get wait_pick {
    return Intl.message(
      'Waiting for the first pill of the day!',
      name: 'wait_pick',
      desc: '',
      args: [],
    );
  }

  /// `Time left`
  String get time_left {
    return Intl.message(
      'Time left',
      name: 'time_left',
      desc: '',
      args: [],
    );
  }

  /// `The previous ball`
  String get prev_ball {
    return Intl.message(
      'The previous ball',
      name: 'prev_ball',
      desc: '',
      args: [],
    );
  }

  /// `The next ball`
  String get next_ball {
    return Intl.message(
      'The next ball',
      name: 'next_ball',
      desc: '',
      args: [],
    );
  }

  /// `When did I take today?`
  String get when_did {
    return Intl.message(
      'When did I take today?',
      name: 'when_did',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Name off pill`
  String get name_pill {
    return Intl.message(
      'Name off pill',
      name: 'name_pill',
      desc: '',
      args: [],
    );
  }

  /// `List off pill`
  String get list_pill {
    return Intl.message(
      'List off pill',
      name: 'list_pill',
      desc: '',
      args: [],
    );
  }

  /// `Describe`
  String get describe {
    return Intl.message(
      'Describe',
      name: 'describe',
      desc: '',
      args: [],
    );
  }

  /// `Duration take pill`
  String get duration_pill {
    return Intl.message(
      'Duration take pill',
      name: 'duration_pill',
      desc: '',
      args: [],
    );
  }

  /// `Bed time`
  String get time_bed {
    return Intl.message(
      'Bed time',
      name: 'time_bed',
      desc: '',
      args: [],
    );
  }

  /// `Start time`
  String get start_time {
    return Intl.message(
      'Start time',
      name: 'start_time',
      desc: '',
      args: [],
    );
  }

  /// `Day of the week`
  String get day_of_week {
    return Intl.message(
      'Day of the week',
      name: 'day_of_week',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get sun {
    return Intl.message(
      'Sun',
      name: 'sun',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get mon {
    return Intl.message(
      'Mon',
      name: 'mon',
      desc: '',
      args: [],
    );
  }

  /// `Tue`
  String get tue {
    return Intl.message(
      'Tue',
      name: 'tue',
      desc: '',
      args: [],
    );
  }

  /// `Wed`
  String get wed {
    return Intl.message(
      'Wed',
      name: 'wed',
      desc: '',
      args: [],
    );
  }

  /// `Thu`
  String get thu {
    return Intl.message(
      'Thu',
      name: 'thu',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get fri {
    return Intl.message(
      'Fri',
      name: 'fri',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get sat {
    return Intl.message(
      'Sat',
      name: 'sat',
      desc: '',
      args: [],
    );
  }

  /// `Number take pill`
  String get number {
    return Intl.message(
      'Number take pill',
      name: 'number',
      desc: '',
      args: [],
    );
  }

  /// `{hour} hours`
  String hour_option(int hour) {
    return Intl.message(
      '$hour hours',
      name: 'hour_option',
      desc: '',
      args: [hour],
    );
  }

  /// `{count} times`
  String count_option(int count) {
    return Intl.message(
      '$count times',
      name: 'count_option',
      desc: '',
      args: [count],
    );
  }

  /// `It's time to take medicine {med}`
  String title_noti(String med) {
    return Intl.message(
      'It\'s time to take medicine $med',
      name: 'title_noti',
      desc: '',
      args: [med],
    );
  }

  /// `Don't forget to mark it as "I took this pill"`
  String get content_noti {
    return Intl.message(
      'Don\'t forget to mark it as "I took this pill"',
      name: 'content_noti',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `The last pill is after bedtime!`
  String get bedtime_before_title {
    return Intl.message(
      'The last pill is after bedtime!',
      name: 'bedtime_before_title',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to edit settings?`
  String get bedtime_before_content {
    return Intl.message(
      'Do you want to edit settings?',
      name: 'bedtime_before_content',
      desc: '',
      args: [],
    );
  }

  /// `The next pill is after bedtime!`
  String get bedtime_before_next_title {
    return Intl.message(
      'The next pill is after bedtime!',
      name: 'bedtime_before_next_title',
      desc: '',
      args: [],
    );
  }

  /// `Do you want an alarm next pill?`
  String get bedtime_before_next_content {
    return Intl.message(
      'Do you want an alarm next pill?',
      name: 'bedtime_before_next_content',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the medicine's name`
  String get error_name_null {
    return Intl.message(
      'Please enter the medicine\'s name',
      name: 'error_name_null',
      desc: '',
      args: [],
    );
  }

  /// `Medicine name already exists`
  String get error_name_duplicate {
    return Intl.message(
      'Medicine name already exists',
      name: 'error_name_duplicate',
      desc: '',
      args: [],
    );
  }

  /// `Please select the reminder's number`
  String get error_interval {
    return Intl.message(
      'Please select the reminder\'s number',
      name: 'error_interval',
      desc: '',
      args: [],
    );
  }

  /// `Bed time can't less than start time`
  String get error_valid_start_time {
    return Intl.message(
      'Bed time can\'t less than start time',
      name: 'error_valid_start_time',
      desc: '',
      args: [],
    );
  }

  /// `You don't have a medicine alarm!`
  String get no_alarm {
    return Intl.message(
      'You don\'t have a medicine alarm!',
      name: 'no_alarm',
      desc: '',
      args: [],
    );
  }

  /// `Create a new medicine alarm!`
  String get create_new {
    return Intl.message(
      'Create a new medicine alarm!',
      name: 'create_new',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for the first pill of tomorrow!`
  String get wait_tomorrow {
    return Intl.message(
      'Waiting for the first pill of tomorrow!',
      name: 'wait_tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `You don't need to take this pill today!`
  String get dont_take {
    return Intl.message(
      'You don\'t need to take this pill today!',
      name: 'dont_take',
      desc: '',
      args: [],
    );
  }

  /// `Delete the medicine alarm!`
  String get delete_medicine_title {
    return Intl.message(
      'Delete the medicine alarm!',
      name: 'delete_medicine_title',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this medicine alarm?`
  String get delete_medicine {
    return Intl.message(
      'Do you want to delete this medicine alarm?',
      name: 'delete_medicine',
      desc: '',
      args: [],
    );
  }

  /// `Cancel the last take pill?`
  String get cancel_last {
    return Intl.message(
      'Cancel the last take pill?',
      name: 'cancel_last',
      desc: '',
      args: [],
    );
  }

  /// `Add Pill`
  String get add_pill {
    return Intl.message(
      'Add Pill',
      name: 'add_pill',
      desc: '',
      args: [],
    );
  }

  /// `Edit Pill`
  String get edit_pill {
    return Intl.message(
      'Edit Pill',
      name: 'edit_pill',
      desc: '',
      args: [],
    );
  }

  /// `When take pill?`
  String get take_time {
    return Intl.message(
      'When take pill?',
      name: 'take_time',
      desc: '',
      args: [],
    );
  }

  /// `You have another pill same start time`
  String get same_start {
    return Intl.message(
      'You have another pill same start time',
      name: 'same_start',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to change the start time?`
  String get want_change {
    return Intl.message(
      'Do you want to change the start time?',
      name: 'want_change',
      desc: '',
      args: [],
    );
  }

  /// `Remind later`
  String get remind_later {
    return Intl.message(
      'Remind later',
      name: 'remind_later',
      desc: '',
      args: [],
    );
  }

  /// `Remind me in 10 minutes`
  String get remind {
    return Intl.message(
      'Remind me in 10 minutes',
      name: 'remind',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'he'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
