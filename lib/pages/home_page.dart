import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:medicine_alarm/generated/l10n.dart';
import 'package:medicine_alarm/global_bloc.dart';
import 'package:medicine_alarm/models/medicine.dart';
import 'package:medicine_alarm/pages/medicine_details/medicine_details.dart';
import 'package:medicine_alarm/pages/new_entry/new_entry_page.dart';
import 'package:medicine_alarm/utils/noti_utils.dart';
import 'package:medicine_alarm/utils/time_utils.dart';
import 'package:medicine_alarm/widgets/bouncing_button.dart';
import 'package:medicine_alarm/widgets/countdown_timer.dart';
import 'package:medicine_alarm/widgets/custom_progress.dart';
import 'package:medicine_alarm/widgets/empty_widget.dart';
import 'package:one_clock/one_clock.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Medicine? selectedMed;

  GlobalBloc? globalBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    globalBloc ??= Provider.of<GlobalBloc>(context);
    var id = ModalRoute.of(context)?.settings.arguments;
    if (id != null) {
      selectedMed = globalBloc?.findById(id as int);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
              onPressed: () async {
                if (selectedMed != null) {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MedicineDetails(selectedMed!);
                      },
                    ),
                  );
                  setState(() {
                    selectedMed = null;
                  });
                }
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 90.h,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: buildBody(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: InkResponse(
        onTap: () {
          // go to new entry page
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const NewEntryPage();
            },
          );
        },
        child: SizedBox(
          width: 64,
          height: 64,
          child: Card(
            color: kPrimaryColor,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(3.h),
            ),
            child: const Icon(
              Icons.add_outlined,
              color: kScaffoldColor,
              size: 48,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        StreamBuilder<String?>(
            stream: globalBloc?.userName$,
            builder: (context, snapshot) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 1.h),
                child: Text(
                  S.current.hello(snapshot.data ?? ""),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            }),
        StreamBuilder<List<Medicine>>(
            stream: globalBloc?.medicineList$,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data?.isNotEmpty == true) {
                if (snapshot.data?.contains(selectedMed) == false) {
                  selectedMed = snapshot.data?.first;
                }
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Column(
                        children: [
                          Text(
                            S.current.need_take,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 4.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.0),
                                color: kPrimaryColor),
                            padding: EdgeInsets.symmetric(horizontal: 1.h),
                            child: DropdownButton<Medicine>(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              underline: const SizedBox(),
                              dropdownColor: kPrimaryColor,
                              value: selectedMed ?? snapshot.data?.first,
                              onChanged: (Medicine? newValue) {
                                setState(() {
                                  selectedMed = newValue;
                                });
                              },
                              items: snapshot.data!.map((Medicine medicine) {
                                return DropdownMenuItem<Medicine>(
                                  value: medicine,
                                  child: Text(
                                    medicine.getName,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      buildClock(),
                      const SizedBox(
                        height: 16,
                      ),
                      if (selectedMed!.getActive()) ...[
                        buildProgress(),
                        const SizedBox(
                          height: 16,
                        ),
                        buildTook(),
                        const SizedBox(
                          height: 16,
                        ),
                        buildWhenDid(),
                        const SizedBox(
                          height: 16,
                        ),
                      ] else ...[
                        Text(
                          S.current.dont_take,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10.h,
                        )
                      ]
                    ],
                  ),
                );
              }
              return const Expanded(child: EmptyWidget());
            })
      ],
    );
  }

  Widget buildClock() {
    return Column(
      children: [
        Text(
          S.current.what_time,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/analog.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: AnalogClock(
                  width: 100,
                  height: 100,
                  isLive: true,
                  hourHandColor: kPrimaryColor,
                  minuteHandColor: kPrimaryColor,
                  secondHandColor: kOrange,
                  showNumbers: false,
                  showTicks: false,
                  showDigitalClock: false,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                    color: kPrimaryColor),
                child: Text(
                    TimeUtils.convertTime(TimeUtils.pattern_1, DateTime.now()),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ))),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                  color: kPrimaryColor),
              child: const DigitalClock(
                showSeconds: true,
                textScaleFactor: 0.9,
                digitalClockTextColor: Colors.white,
                format: TimeUtils.pattern_2,
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 1),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildWhenDid() {
    return isBefore()
        ? Container()
        : SizedBox(
            width: 100.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  S.current.when_did,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                Wrap(
                  children: selectedMed!.pickTimes?.map((e) {
                        var time = e;
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          margin: const EdgeInsets.only(right: 8, top: 8),
                          decoration: BoxDecoration(
                              color: kBackground,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            TimeUtils.convertTime(TimeUtils.pattern_4, time),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList() ??
                      [],
                )
              ],
            ),
          );
  }

  Widget buildProgress() {
    if (selectedMed == null) {
      return Container();
    }
    var last = selectedMed!.pickTimes?.isNotEmpty == true
        ? selectedMed!.pickTimes!.last
        : DateTime.now();
    return Column(
      children: [buildActiveProgress(last)],
    );
  }

  Widget buildActiveProgress(DateTime last) {
    return isBefore()
        ? Text(
            S.current.wait_pick,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.black),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20.w,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                          color: kPrimaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                          TimeUtils.convertTime(TimeUtils.pattern_4, last),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: 158,
                    height: 158,
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Image.asset(
                              'assets/images/progress.jpg',
                              fit: BoxFit.cover,
                              width: 151,
                              height: 151,
                            ),
                          ),
                        ),
                        Center(
                          child: CountdownTimer(
                            startTime: last,
                            nextTime: selectedMed!.next,
                            onCount: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                setState(() {});
                              });
                            },
                            done: selectedMed!.doneToday(),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 158,
                            height: 158,
                            child: CustomProgressWidget(
                              strokeWidth: 18.5,
                              progress: selectedMed!.getPercent(),
                              progressColor: kPrimaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  selectedMed!.doneToday() && selectedMed!.next == null
                      ? SizedBox(
                          width: 20.w,
                          child: Text(S.current.wait_tomorrow,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleSmall),
                        )
                      : SizedBox(
                          width: 20.w,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.0),
                                color: kPrimaryColor),
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                                TimeUtils.convertTime(
                                    TimeUtils.pattern_4, selectedMed!.next!),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.white)),
                          ),
                        ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 22.w,
                    child: Text(S.current.prev_ball,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  Container(
                    width: 22.w,
                    margin: EdgeInsets.only(right: 2.w),
                    child: Text(S.current.time_left,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  selectedMed!.doneToday()
                      ? SizedBox(
                          width: 20.w,
                        )
                      : SizedBox(
                          width: 20.w,
                          child: Text(S.current.next_ball,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleSmall),
                        )
                ],
              )
            ],
          );
  }

  Widget buildTook() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: selectedMed!.pickTimes?.isNotEmpty == false
                ? null
                : () {
                    NotificationService().openAlertBox(S.current.cancel_last,
                        onPositive: () async {
                      globalBloc?.cancelLastPill(selectedMed!);
                      NotificationService()
                          .scheduleNotification(selectedMed!, globalBloc);
                      setState(() {});
                    });
                  },
            icon: Icon(
              Icons.cancel_presentation,
              size: 32,
              color: selectedMed!.pickTimes?.isNotEmpty == false
                  ? Colors.black26
                  : kPrimaryColor,
            )),
        BouncingButton(
          enable: selectedMed!.isFire() && !selectedMed!.doneToday(),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                disabledBackgroundColor: Colors.black26,
                backgroundColor: kOrange),
            onPressed: selectedMed!.doneToday()
                ? null
                : () async {
                    var last = selectedMed!.last;
                    var isOk = true;
                    if (last != null) {
                      var diff = DateTime.now().difference(last);
                      if (!diff.isNegative && diff.inMinutes <= 30) {
                        await NotificationService().openAlertBox(
                          S.current.confirm_took,
                          negative: S.current.no,
                          positive: S.current.yes,
                          onNegative: () {
                            isOk = false;
                          },
                        );
                      }
                    }
                    if (isOk) {
                      globalBloc?.tookPill(selectedMed!);
                      NotificationService()
                          .scheduleNotification(selectedMed!, globalBloc);
                      setState(() {});
                    }
                  },
            child: SizedBox(
              width: 70.w,
              child: Center(
                child: Text(
                  S.current.i_took,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool isBefore() {
    var lastPick = selectedMed!.last;
    return lastPick == null;
  }
}
