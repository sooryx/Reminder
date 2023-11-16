import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder/screens/add_reminder.dart';
import 'package:reminder/screens/homepage.dart';
import 'package:reminder/screens/onboarding_screen.dart';
import 'firebase_options.dart';


///APK file is also in the main directory[Reminder/app-release.apk].

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    await initNotifications();
    print("Success");
  }catch(e){
    print('error:$e');
  }
  runApp(const MyApp());
}

Future<void> initNotifications() async {
  // Initialize the plugin here
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    ///ScreenUtil is used to make the responsive

    return ScreenUtilInit(
        designSize: const Size(392.72727272727275, 850.9090909090909),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home:  OnboardingScreen(),
            routes: {
                '/home': (context) => const Homepage(),
              '/add_reminder':(context)=>  AddReminder()
              });
        }
    );
  }
}


