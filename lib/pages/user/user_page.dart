import 'package:flutter/material.dart';
import 'package:medicine_alarm/constants.dart';
import 'package:medicine_alarm/generated/l10n.dart';
import 'package:medicine_alarm/global_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late TextEditingController nameController;
  GlobalBloc? globalBloc;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    globalBloc ??= Provider.of<GlobalBloc>(context);
  }

  void displayError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kPrimaryColor.withOpacity(0.5),
        content: Text(
          error,
          style: const TextStyle(color: Colors.red),
        ),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(2.h),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  Column(
                    children: [
                      Text(
                        "${S.of(context).app_name}!",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        S.current.reminder_take,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Image.asset(
                      "assets/images/clock.png",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: S.current.your_name,
                        enabledBorder: noOutLineBorder,
                        focusedBorder: noOutLineBorder,
                        errorBorder: noOutLineBorder,
                        focusedErrorBorder: noOutLineBorder,
                        filled: true,
                        fillColor: kPrimaryColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor),
                        onPressed: () {
                          var user = nameController.text;
                          if (user.isEmpty) {
                            displayError(S.current.name_null);
                          } else {
                            globalBloc?.updateUser(nameController.text);
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              S.current.next,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
