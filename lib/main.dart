import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_alarm/pages/user/user_page.dart';
import 'package:medicine_alarm/utils/noti_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'constants.dart';
import 'generated/l10n.dart';
import 'global_bloc.dart';
import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
  runApp(const MyApp());
  await NotificationService().initNotification();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  GlobalBloc? globalBloc;

  @override
  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc!,
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: NotificationService.navigatorKey,
          // set property
          title: "Medical Alarm",
          onGenerateTitle: (BuildContext context) => S.of(context).app_name,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          //theme customization
          theme: ThemeData.dark().copyWith(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: kScaffoldColor,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
            ),
            //appbar theme
            appBarTheme: AppBarTheme(
              toolbarHeight: 7.h,
              backgroundColor: kScaffoldColor,
              elevation: 0,
              iconTheme: IconThemeData(
                color: kSecondaryColor,
                size: 20.sp,
              ),
              titleTextStyle: GoogleFonts.openSans(
                color: kTextColor,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.normal,
                fontSize: 16.sp,
              ),
            ),
            textTheme: TextTheme(
              displaySmall: GoogleFonts.openSans(
                fontSize: 28.sp,
                color: kSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
              headlineMedium: GoogleFonts.openSans(
                fontSize: 22.sp,
                color: kTitleColor,
                fontWeight: FontWeight.bold,
              ),
              headlineSmall: GoogleFonts.openSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: kTitleColor,
              ),
              titleLarge: GoogleFonts.openSans(
                fontSize: 13.sp,
                color: kTextColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
              titleMedium: GoogleFonts.openSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: kTextPrime),
              titleSmall: GoogleFonts.openSans(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              bodySmall: GoogleFonts.openSans(
                fontSize: 9.sp,
                fontWeight: FontWeight.w400,
                color: kTextColor,
              ),
              labelMedium: GoogleFonts.openSans(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: kTextColor,
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kTextLightColor,
                  width: 0.7,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: kTextLightColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
            ),
            //lets customize the timePicker theme
            timePickerTheme: TimePickerThemeData(
              backgroundColor: kScaffoldColor,
              hourMinuteColor: kTextColor,
              hourMinuteTextColor: kScaffoldColor,
              dayPeriodColor: kTextColor,
              dayPeriodTextColor: kScaffoldColor,
              dialBackgroundColor: kTextColor,
              dialHandColor: kPrimaryColor,
              dialTextColor: kScaffoldColor,
              entryModeIconColor: kOtherColor,
              dayPeriodTextStyle: GoogleFonts.aBeeZee(
                fontSize: 8.sp,
              ),
              helpTextStyle: GoogleFonts.openSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: kTextColor,
              ),
            ),
          ),
          home: StreamBuilder(
            stream: globalBloc?.userName$,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                //if no data is saved
                return Container();
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const UserPage();
              } else {
                return const HomePage();
              }
            },
          ),
        );
      }),
    );
  }
}
