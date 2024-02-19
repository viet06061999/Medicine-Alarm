import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future removeMedicine(Medicine tobeRemoved) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> medicineJsonList = [];

    var blockList = _medicineList$!.value;
    blockList.removeWhere(
        (medicine) => medicine.medicineName == tobeRemoved.medicineName);

    //remove notifications,todo
    for (int i = 0; i < (24 / tobeRemoved.interval!).floor(); i++) {
      flutterLocalNotificationsPlugin
          .cancel(int.parse(tobeRemoved.notificationIDs![i]));
    }

    if (blockList.isNotEmpty) {
      for (var blockMedicine in blockList) {
        String medicineJson = jsonEncode(blockMedicine.toJson());
        medicineJsonList.add(medicineJson);
      }
    }

    sharedUser.setStringList('medicines', medicineJsonList);
    _medicineList$!.add(blockList);
  }

  Future tookPill(Medicine medicine) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();

    var blockList = _medicineList$!.value;
    var element = blockList.firstWhere((e) => medicine.id == e.id);
    var lastPick = element.pickTimes?.last;
    var isNotPick = lastPick == null ||
        TimeUtils.isBeforeStart(lastPick, element.startTime!);
    if (isNotPick) {
      element.pickTimes = [];
    }
    element.pickTimes?.add(DateTime.now());
    List<String> medicineJsonList =
        blockList.map((e) => jsonEncode(e.toJson())).toList();
    sharedUser.setStringList('medicines', medicineJsonList);
    _medicineList$!.add(blockList);
    NotificationService().scheduleNextNotification(medicine);
  }

  Future updateMedicineList(Medicine newMedicine) async {
    var blocList = _medicineList$!.value;
    blocList.add(newMedicine);
    _medicineList$!.add(blocList);

    Map<String, dynamic> tempMap = newMedicine.toJson();
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
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

  Future makeMedicineList() async {
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    List<String>? jsonList = sharedUser.getStringList('medicines');
    List<Medicine> prefList = [];

    if (jsonList == null) {
      return;
    } else {
      for (String jsonMedicine in jsonList) {
        dynamic userMap = jsonDecode(jsonMedicine);
        Medicine tempMedicine = Medicine.fromJson(userMap);
        prefList.add(tempMedicine);
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
