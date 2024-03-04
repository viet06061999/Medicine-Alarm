import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';
import 'models/errors.dart';
import 'models/medicine.dart';
import 'utils/noti_utils.dart';
import 'utils/time_utils.dart';

class GlobalBloc {
  BehaviorSubject<List<Medicine>>? _medicineList$;

  BehaviorSubject<List<Medicine>>? get medicineList$ => _medicineList$;
  BehaviorSubject<String?>? _userName$;

  BehaviorSubject<String?>? get userName$ => _userName$;
  BehaviorSubject<EntryError>? _errorState$;

  BehaviorSubject<EntryError>? get errorState$ => _errorState$;

  GlobalBloc() {
    _medicineList$ = BehaviorSubject<List<Medicine>>.seeded([]);
    _userName$ = BehaviorSubject<String>.seeded("");
    _errorState$ = BehaviorSubject<EntryError>.seeded(EntryError.none);
    makeMedicineList();
    fetchUser();
  }

  Medicine findById(int id) {
    var blockList = _medicineList$!.value;
    return blockList.firstWhere((e) => id == e.id);
  }

  Future<int> removeMedicine(Medicine tobeRemoved, {isUpdate = false}) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> medicineJsonList = [];

    var blockList = _medicineList$!.value;
    var index = blockList.indexWhere(
        (medicine) => medicine.medicineName == tobeRemoved.medicineName);
    blockList.removeWhere(
        (medicine) => medicine.medicineName == tobeRemoved.medicineName);

    NotificationService().cancelAll(tobeRemoved);

    if (blockList.isNotEmpty) {
      for (var blockMedicine in blockList) {
        String medicineJson = jsonEncode(blockMedicine.toJson());
        medicineJsonList.add(medicineJson);
      }
    }

    sharedUser.setStringList('medicines', medicineJsonList);
    _medicineList$!.add(blockList);
    return index;
  }

  Future tookPill(Medicine medicine) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    var blockList = _medicineList$!.value;
    var element = blockList.firstWhere((e) => medicine.id == e.id);
    var isNotPick = element.last == null;
    if (isNotPick) {
      element.pickTimes = [];
    }
    element.pickTimes?.add(DateTime.now());
    List<String> medicineJsonList =
        blockList.map((e) => jsonEncode(e.toJson())).toList();
    sharedUser.setStringList('medicines', medicineJsonList);
    _medicineList$!.add(blockList);
  }

  Future cancelLastPill(Medicine medicine) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();

    var blockList = _medicineList$!.value;
    var element = blockList.firstWhere((e) => medicine.id == e.id);
    var isNotPick = element.last == null;
    if (isNotPick) {
      return;
    }
    element.isDoneOfDay = false;
    element.pickTimes?.removeLast();
    if (element.pickTimes?.isNotEmpty == false) {
      element.pickTimes = null;
    }
    List<String> medicineJsonList =
        blockList.map((e) => jsonEncode(e.toJson())).toList();
    sharedUser.setStringList('medicines', medicineJsonList);
    _medicineList$!.add(blockList);
  }

  Future updateDone(Medicine medicine, bool done) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    var blockList = _medicineList$!.value;
    var element = blockList.firstWhere((e) => medicine.id == e.id);
    element.isDoneOfDay = done;
    List<String> medicineJsonList =
        blockList.map((e) => jsonEncode(e.toJson())).toList();
    sharedUser.setStringList('medicines', medicineJsonList);
    _medicineList$!.add(blockList);
  }

  Future updateMedicineList(Medicine newMedicine, {int? index}) async {
    var blocList = _medicineList$!.value;
    if (index != null) {
      blocList.insert(index, newMedicine);
    } else {
      blocList.add(newMedicine);
    }
    _medicineList$!.add(blocList);
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    Map<String, dynamic> tempMap = newMedicine.toJson();
    String newMedicineJson = jsonEncode(tempMap);
    List<String> medicineJsonList = [];
    if (sharedUser.getStringList('medicines') == null) {
      medicineJsonList.add(newMedicineJson);
    } else {
      medicineJsonList = sharedUser.getStringList('medicines')!;
      medicineJsonList.add(newMedicineJson);
    }
    sharedUser.setStringList('medicines', medicineJsonList);
  }

  Future updateMedicine(Medicine medicine) async {
    var blocList = _medicineList$!.value;
    var index = blocList.indexWhere((element) => medicine.id == element.id);
    if (index != -1) {
      blocList[index] = medicine;
      _medicineList$!.add(blocList);
      Map<String, dynamic> tempMap = medicine.toJson();
      SharedPreferences? sharedUser = await SharedPreferences.getInstance();
      List<String> medicineJsonList = [];
      medicineJsonList = blocList.map((e) {
        Map<String, dynamic> tempMap = e.toJson();
        return jsonEncode(tempMap);
      }).toList();
      sharedUser.setStringList('medicines', medicineJsonList);
    }
  }

  bool checkSameStart(TimeOfDay startTime, int? id) {
    var blocList = _medicineList$!.value;
    return blocList.any((element) =>
        element.id != id &&
        startTime.hour == element.startTime.hour &&
        startTime.minute == element.startTime.minute);
  }

  Future makeMedicineList() async {
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    List<String>? jsonList = sharedUser.getStringList('medicines');
    List<Medicine> prefList = [];
    if (jsonList == null) {
      return;
    } else {
      var isChange = false;
      for (String jsonMedicine in jsonList) {
        dynamic userMap = jsonDecode(jsonMedicine);
        Medicine tempMedicine = Medicine.fromJson(userMap);
        var lastTime = tempMedicine.last;
        var now = DateTime.now();
        if (lastTime != null &&
            (lastTime.year < now.year ||
                lastTime.month < now.month ||
                lastTime.day < now.day)) {
          isChange = true;
          tempMedicine.pickTimes = [];
        }
        prefList.add(tempMedicine);
      }
      if (isChange) {
        jsonList = prefList.map((e) => jsonEncode(e.toJson())).toList();
        sharedUser.setStringList('medicines', jsonList);
      }
      //state update
      _medicineList$!.add(prefList);
    }
  }

  Future fetchUser() async {
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    var user = sharedUser.getString('user');
    if (user != null) {
      _userName$?.add(user);
    }
  }

  Future updateUser(String? user) async {
    if (user != null) {
      SharedPreferences? sharedUser = await SharedPreferences.getInstance();
      sharedUser.setString('user', user);
      _userName$?.add(user);
    }
  }

  void dispose() {
    _medicineList$!.close();
    _userName$?.close();
    _errorState$?.close();
  }
}
