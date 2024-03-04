import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:medicine_alarm/generated/l10n.dart';
import 'package:medicine_alarm/global_bloc.dart';
import 'package:medicine_alarm/models/errors.dart';
import 'package:medicine_alarm/models/medicine.dart';
import 'package:medicine_alarm/pages/home_page.dart';
import 'package:medicine_alarm/pages/new_entry/new_entry_bloc.dart';
import 'package:medicine_alarm/pages/success_screen/success_screen.dart';
import 'package:medicine_alarm/utils/noti_utils.dart';
import 'package:medicine_alarm/utils/time_utils.dart';
import 'package:medicine_alarm/widgets/alarm_time.dart';
import 'package:medicine_alarm/widgets/item_time.dart';
import 'package:medicine_alarm/widgets/select_day.dart';
import 'package:medicine_alarm/widgets/select_time.dart';
import 'package:medicine_alarm/widgets/text_field_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({Key? key}) : super(key: key);

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  late TextEditingController nameController;
  late TextEditingController dosageController;
  TextEditingController? listPillController;
  TextEditingController? desController;
  late NewEntryBloc _newEntryBloc;
  GlobalBloc? globalBloc;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  List<TimeOfDay> timeAlarms = [];

  void _selectStartTime(TimeOfDay? picked) async {
    if (picked != null && picked != startTime) {
      setState(() {
        startTime = picked;
        _newEntryBloc.updateStartTime(startTime);
      });
    }
  }

  void _selectEndTime(TimeOfDay? picked) async {
    if (picked != null && picked != endTime) {
      setState(() {
        endTime = picked;
        _newEntryBloc.updateEndTime(endTime);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    _newEntryBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    listPillController = TextEditingController();
    desController = TextEditingController();
    _newEntryBloc = NewEntryBloc();
    initializeErrorListen();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    globalBloc = Provider.of<GlobalBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Provider<NewEntryBloc>.value(
      value: _newEntryBloc,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        height: 88.h,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 3,
                  decoration: BoxDecoration(
                      color: kGray, borderRadius: BorderRadius.circular(4)),
                ),
              ),
              buildTop(),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    children: [
                      TextFieldWidget(
                        'assets/icons/medicine-icon.svg',
                        S.current.name_pill,
                        null,
                        nameController,
                        isEditing: true,
                        isRequired: true,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ItemTime(
                        context: context,
                        icon: "assets/icons/alarm-icon-1.svg",
                        title: S.current.start_time,
                        child: SelectTime(
                          onSelect: _selectStartTime,
                          time: _newEntryBloc.selectedStartTime$?.value,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: kPrimaryColor),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            child: Text(
                              TimeUtils.formatTimeOfDay(
                                  time: _newEntryBloc
                                      .selectedStartTime$?.value,
                                  defaultText: "00:00") ??
                                  "",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ItemTime(
                        context: context,
                        icon: "assets/icons/bedtime-icon.svg",
                        title: S.current.time_bed,
                        child: SelectTime(
                          onSelect: _selectEndTime,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: kPrimaryColor),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            child: Text(
                              TimeUtils.formatTimeOfDay(
                                  time:
                                  _newEntryBloc.selectedEndTime$?.value,
                                  defaultText: "23:59") ??
                                  "",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: 94.w,
                        child: IntervalSelection(
                          onSelected: (value) {
                            setState(() {
                              _newEntryBloc.updateCount(value);
                            });
                          },
                          getText: S.current.count_option,
                          intervals: const [1, 2, 3, 4, 5, 6],
                          child: ItemTime(
                            context: context,
                            icon: "assets/icons/counting.svg",
                            title: S.current.number,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: kPrimaryColor),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              child: Text(
                                S.current.count_option(
                                    _newEntryBloc.selectCount?.value ?? 0),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      AlarmTime(
                        startTime: _newEntryBloc.selectedStartTime$?.value ??
                            const TimeOfDay(hour: 0, minute: 0),
                        endTime: _newEntryBloc.selectedEndTime$?.value ??
                            const TimeOfDay(hour: 23, minute: 59),
                        count: _newEntryBloc.selectCount?.value ?? 0,
                        onTime: (times) {
                          timeAlarms = times;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SelectDayWeek(
                        enable: true,
                        onSelect: (values) {
                          _newEntryBloc.updateDaySelect(values);
                        },
                      ),
                      TextFieldWidget(
                        'assets/icons/file-black-icon.svg',
                        S.current.list_pill,
                        null,
                        listPillController,
                        isEditing: true,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFieldWidget(
                        "assets/icons/instruction-manuals-book-icon.svg",
                        S.current.describe,
                        null,
                        desController,
                        line: 3,
                        isEditing: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onConfirm() async {
    //add medicine
    //some validations
    //go to success screen
    String? medicineName;

    //medicineName
    if (nameController.text == "") {
      _newEntryBloc.submitError(EntryError.nameNull);
      return;
    }
    if (nameController.text != "") {
      medicineName = nameController.text;
    }
    //dosage
    for (var medicine in globalBloc!.medicineList$!.value) {
      if (medicineName == medicine.medicineName) {
        _newEntryBloc.submitError(EntryError.nameDuplicate);
        return;
      }
    }
    int number = _newEntryBloc.selectCount!.value;
    TimeOfDay startTime = _newEntryBloc.selectedStartTime$?.value ??
        const TimeOfDay(hour: 00, minute: 00);
    TimeOfDay bedTime = _newEntryBloc.selectedEndTime$?.value ??
        const TimeOfDay(hour: 23, minute: 59);
    List<String> days = _newEntryBloc.selectedDay$?.value ?? [];
    var needEdit = false;
    if (!TimeUtils.isValidStart(startTime, bedTime)) {
      _newEntryBloc.submitError(EntryError.validStartTime);
      return;
    }
    // if (TimeUtils.isAfterEnd(startTime, bedTime, interval, number)) {
    //   await NotificationService().openAlertBox(S.current.bedtime_before_title,
    //       content: S.current.bedtime_before_content,
    //       negative: S.current.no,
    //       positive: S.current.yes, onPositive: () {
    //     needEdit = true;
    //   });
    // }

    if (globalBloc?.checkSameStart(startTime, null) == true) {
      await NotificationService().openAlertBox(S.current.same_start,
          content: S.current.want_change,
          negative: S.current.no,
          positive: S.current.yes, onPositive: () {
            needEdit = true;
          });
    }

    if (needEdit) {
      return;
    }
    Medicine newEntryMedicine = Medicine(Random().nextInt(99999), days,
        notificationIDs: [],
        medicineName: medicineName,
        number: number,
        startTime: startTime,
        bedTime: bedTime,
        listPill: listPillController?.text,
        description: desController?.text,
        times: timeAlarms);

    //update medicine list via global bloc
    globalBloc?.updateMedicineList(newEntryMedicine);

    //schedule notification
    NotificationService().scheduleNotification(newEntryMedicine, globalBloc);
    if (mounted) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SuccessScreen()));
    }
  }

  Widget buildTop() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
            minWidth: 24,
            child: SvgPicture.asset(
              'assets/icons/close-window-icon.svg',
              height: 24,
            ),
          ),
          Text(
            S.current.add_pill,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: kPrimaryColor),
          ),
          MaterialButton(
            onPressed: () {
              onConfirm();
            },
            padding: EdgeInsets.zero,
            minWidth: 24,
            child: SvgPicture.asset(
              'assets/icons/check-mark-box-icon.svg',
              height: 24,
            ),
          ),
        ],
      ),
    );
  }

  void initializeErrorListen() {
    _newEntryBloc.errorState$!.listen((EntryError error) {
      switch (error) {
        case EntryError.nameNull:
          displayError(S.current.error_name_null);
          break;
        case EntryError.nameDuplicate:
          displayError(S.current.error_name_duplicate);
          break;
        case EntryError.interval:
          displayError(S.current.error_interval);
          break;
        case EntryError.validStartTime:
          displayError(S.current.error_valid_start_time);
          break;
        default:
      }
    });
  }

  void displayError(String error) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black.withOpacity(0.8),
        content: Text(
          error,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.red),
        ),
        duration: const Duration(milliseconds: 3000),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}

class IntervalSelection extends StatefulWidget {
  final Widget child;
  final List<int> intervals;
  final Function(int) onSelected;
  final Function(int) getText;

  const IntervalSelection(
      {super.key,
        required this.child,
        required this.onSelected,
        required this.getText,
        required this.intervals});

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (BuildContext context) {
        return widget.intervals
            .map((e) => PopupMenuItem<int>(
          value: e,
          child: Text(widget.getText(e)),
        ))
            .toList();
      },
      onSelected: widget.onSelected,
      child: widget.child,
    );
  }
}
