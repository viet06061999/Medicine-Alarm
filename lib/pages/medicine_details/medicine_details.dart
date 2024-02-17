import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:medicine_alarm/generated/l10n.dart';
import 'package:medicine_alarm/global_bloc.dart';
import 'package:medicine_alarm/models/medicine.dart';
import 'package:medicine_alarm/widgets/day_picker/model/day_in_week.dart';
import 'package:medicine_alarm/widgets/day_picker/select_day.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MedicineDetails extends StatefulWidget {
  MedicineDetails(this.medicine, {Key? key}) : super(key: key);
  Medicine medicine;

  @override
  State<MedicineDetails> createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  GlobalBloc? globalBloc;
  bool isEditing = false;
  TextEditingController? nameController;
  TextEditingController? listPillController;
  FocusNode focusNode = FocusNode();
  TextEditingController? desController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initController();
  }

  initController() {
    nameController = TextEditingController(text: widget.medicine.medicineName);
    listPillController = TextEditingController(text: widget.medicine.listPill);
    desController = TextEditingController(text: widget.medicine.description);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    globalBloc ??= Provider.of<GlobalBloc>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        title: Text(
          S.current.settings,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white),
        ),
        titleSpacing: 0.5,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                  if (isEditing) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      focusNode.requestFocus();
                    });
                  }
                });
              },
              icon: const Icon(
                Icons.edit_note,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_box_sharp,
                color: Colors.white,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 90.h,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              StreamBuilder<List<Medicine>>(
                  stream: globalBloc?.medicineList$,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data?.isNotEmpty == true) {
                      return Container(
                        height: 4.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.0),
                            color: kPrimaryColor),
                        padding: EdgeInsets.symmetric(horizontal: 1.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/pharmacy.svg',
                              height: 24,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            DropdownButton<Medicine>(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              underline: const SizedBox(),
                              dropdownColor: kPrimaryColor,
                              value: widget.medicine,
                              onChanged: (Medicine? newValue) {
                                setState(() {
                                  widget.medicine = newValue!;
                                });
                                initController();
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
                          ],
                        ),
                      );
                    }
                    return const Text("empty");
                  }),
              const SizedBox(
                height: 16,
              ),
              buildItem('assets/icons/medicine-icon.svg', S.current.name_pill,
                  widget.medicine.getName, nameController,
                  focus: focusNode),
              const SizedBox(
                height: 16,
              ),
              buildTime(),
              const SizedBox(
                height: 16,
              ),
              buildItemTime(
                  "assets/icons/alarm-icon.svg",
                  S.current.duration_pill,
                  "${widget.medicine.getInterval <= 9 ? "0${widget.medicine.getInterval}" : widget.medicine.getInterval}:00",
                  35.w),
              const SizedBox(
                height: 16,
              ),
              buildWeek(),
              const SizedBox(
                height: 6,
              ),
              buildItem(
                'assets/icons/file-black-icon.svg',
                S.current.list_pill,
                widget.medicine.listPill,
                listPillController,
              ),
              const SizedBox(
                height: 16,
              ),
              buildItem(
                "assets/icons/instruction-manuals-book-icon.svg",
                S.current.describe,
                widget.medicine.description,
                desController,
                line: 3
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(
    String icon,
    String title,
    String? content,
    TextEditingController? controller, {
    int line = 1,
    FocusNode? focus,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          icon,
          height: 24,
        ),
        const SizedBox(
          width: 12,
        ),
        SizedBox(
          width: 80.w,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: kOrange),
              ),
              const SizedBox(
                height: 8,
              ),
              FocusScope(
                child: TextFormField(
                  controller: controller,
                  readOnly: !isEditing,
                  focusNode: focus,
                  autofocus: true,
                  maxLines: null,
                  minLines: line,
                  decoration: InputDecoration(
                    hintText: content ?? title,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: kHint),
                    enabledBorder: outLineBorder,
                    disabledBorder: outLineBorder,
                    focusedBorder: outLineBorder,
                    errorBorder: outLineBorder,
                    focusedErrorBorder: outLineBorder,
                    filled: true,
                    fillColor: kBackground,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: kPrimaryColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildItemTime(
      String icon, String title, String content, double width) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          icon,
          height: 24,
        ),
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: kOrange),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: kPrimaryColor),
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: Text(
                  content,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTime() {
    return SizedBox(
      width: 94.w,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildItemTime("assets/icons/alarm-icon-1.svg", S.current.start_time,
              widget.medicine.getStartTimeStr, 35.w),
          buildItemTime("assets/icons/bedtime-icon.svg", S.current.time_bed,
              widget.medicine.getStartTimeStr, 35.w),
        ],
      ),
    );
  }

  Widget buildWeek() {
    return Column(children: [
      Row(
        children: [
          SvgPicture.asset(
            "assets/icons/monthly-icon.svg",
            height: 24,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            S.current.day_of_week,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: kOrange),
          ),
        ],
      ),
      // const SizedBox(
      //   height: 8,
      // ),
      SelectWeekDays(
        fontSize: 13,
        padding: 24,
        fontWeight: FontWeight.w500,
        days: [S.current.all],
        onSelect: (values) {
          // <== Callback to handle the selected days
          print(values);
        },
      )
    ]);
  }

  //lets delete a medicine from memory

  openAlertBox(BuildContext context, GlobalBloc _globalBloc) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kScaffoldColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 1.h),
          title: Text(
            'Delete This Reminder?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            TextButton(
              onPressed: () {
                //global block to delete medicine,later
                _globalBloc.removeMedicine(widget.medicine);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text(
                'OK',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: kSecondaryColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
