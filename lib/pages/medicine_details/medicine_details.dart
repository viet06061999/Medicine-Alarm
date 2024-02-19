import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:medicine_alarm/generated/l10n.dart';
import 'package:medicine_alarm/global_bloc.dart';
import 'package:medicine_alarm/models/medicine.dart';
import 'package:medicine_alarm/widgets/day_picker/select_day.dart';
import 'package:medicine_alarm/widgets/item_time.dart';
import 'package:medicine_alarm/widgets/select_day.dart';
import 'package:medicine_alarm/widgets/text_field_widget.dart';
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
              TextFieldWidget('assets/icons/medicine-icon.svg',
                  S.current.name_pill, widget.medicine.getName, nameController,
                  isEditing: isEditing),
              const SizedBox(
                height: 16,
              ),
              buildTime(),
              const SizedBox(
                height: 16,
              ),
              buildTakePill(),
              const SizedBox(
                height: 16,
              ),
              SelectDayWeek(
                enable: false,
                onSelect: (values) {},
                days: widget.medicine.days,
              ),
              const SizedBox(
                height: 6,
              ),
              TextFieldWidget(
                  'assets/icons/file-black-icon.svg',
                  S.current.list_pill,
                  widget.medicine.listPill,
                  listPillController),
              const SizedBox(
                height: 16,
              ),
              TextFieldWidget(
                  "assets/icons/instruction-manuals-book-icon.svg",
                  S.current.describe,
                  widget.medicine.description,
                  desController),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTime() {
    return SizedBox(
      width: 94.w,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ItemTime(
            context: context,
            icon: "assets/icons/alarm-icon-1.svg",
            title: S.current.start_time,
            width: 35.w,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: kPrimaryColor),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              child: Text(
                widget.medicine.getStartTimeStr,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
          ItemTime(
            context: context,
            icon: "assets/icons/bedtime-icon.svg",
            title: S.current.time_bed,
            width: 35.w,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: kPrimaryColor),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              child: Text(
                widget.medicine.geBedTimeStr,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTakePill() {
    return SizedBox(
      width: 94.w,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ItemTime(
            context: context,
            icon: "assets/icons/alarm-icon.svg",
            title: S.current.duration_pill,
            width: 35.w,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: kPrimaryColor),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              child: Text(
                "${widget.medicine.getInterval <= 9 ? "0${widget.medicine.getInterval}" : widget.medicine.getInterval}:00",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
          ItemTime(
            context: context,
            icon: "assets/icons/counting.svg",
            title: S.current.number,
            width: 35.w,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: kPrimaryColor),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              child: Text(
                S.current.count_option(widget.medicine.number ?? 0),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
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
