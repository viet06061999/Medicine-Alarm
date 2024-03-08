import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/errors.dart';

class NewEntryBloc {
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
    _selectedDay$?.close();
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
}
