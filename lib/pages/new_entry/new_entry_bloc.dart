import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/errors.dart';

class NewEntryBloc {
  BehaviorSubject<TimeOfDay?>? _selectedStartTime$;

  BehaviorSubject<TimeOfDay?>? get selectedStartTime$ => _selectedStartTime$;

  BehaviorSubject<TimeOfDay?>? _selectedEndTime$;

  BehaviorSubject<TimeOfDay?>? get selectedEndTime$ => _selectedEndTime$;

  //error state
  BehaviorSubject<EntryError>? _errorState$;

  BehaviorSubject<EntryError>? get errorState$ => _errorState$;

  BehaviorSubject<List<String>?>? _selectedDay$;

  BehaviorSubject<List<String>?>? get selectedDay$ => _selectedDay$;

  BehaviorSubject<int>? _selectedCount$;

  BehaviorSubject<int>? get selectCount => _selectedCount$;

  NewEntryBloc() {
    _selectedCount$ = BehaviorSubject<int>.seeded(0);
    _errorState$ = BehaviorSubject<EntryError>();
    _selectedDay$ = BehaviorSubject<List<String>?>.seeded(["0"]);
  }

  void dispose() {
    _selectedStartTime$?.close();
    _selectedDay$?.close();
    _selectedEndTime$?.close();
  }

  void submitError(EntryError error) {
    _errorState$!.add(error);
  }

  void updateCount(int count) {
    _selectedCount$!.add(count);
  }

  void updateDaySelect(List<String> days) {
    _selectedDay$?.add(days);
  }

  void updateStartTime(TimeOfDay? time) {
    if (_selectedStartTime$ == null) {
      _selectedStartTime$ = BehaviorSubject<TimeOfDay?>.seeded(time);
    } else {
      _selectedStartTime$!.add(time);
    }
  }

  void updateEndTime(TimeOfDay? time) {
    if (_selectedEndTime$ == null) {
      _selectedEndTime$ = BehaviorSubject<TimeOfDay?>.seeded(time);
    } else {
      _selectedEndTime$?.add(time);
    }
  }
}
