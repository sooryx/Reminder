import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart' hide IOSNotificationDetails;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder/widgets/my_button.dart';
import 'package:timezone/timezone.dart' as tz;


class AddReminder extends StatefulWidget {
  AddReminder({Key? key}) : super(key: key);

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  String selectedDay = 'Monday';
  String selectedActivity = 'Wake up';
  TimeOfDay time = const TimeOfDay(hour: 10, minute: 30);
  User? user = FirebaseAuth.instance.currentUser;
  late tz.Location _local = tz.getLocation('Asia/Kolkata');

  ///Initialized the notification plugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  List<String> activities = [
    'Wake up',
    'Go to gym',
    'Breakfast',
    'Meetings',
    'Lunch',
    'Quick nap',
    'Go to library',
    'Dinner',
    'Go to sleep',
  ];

///Storing the data chosen into the firebase and scheduling the notification from the selected data
  _storeReminder() async {
    try {
      String? amPm = time?.period == DayPeriod.am ? 'AM' : 'PM';
      if (user != null) {
        print('Hour type: ${time.hour.runtimeType}, Minute type: ${time.minute.runtimeType}');

        var reminderData = {
          'Task': selectedActivity.toString(),
          'Day': selectedDay.toString(),
          'Hour': time.hour.toString(),
          'Minute': time.minute.toString(),
          'AM/PM': amPm,
        };

        print('Reminder Data: $reminderData');

        await FirebaseFirestore.instance
            .collection("User Reminder")
            .doc(user!.uid)
            .collection("Reminders")
            .add(reminderData);

        ///Schedule notification is called here
try {
  await scheduleNotification(
    selectedActivity,
    selectedDay,
    time.hour,
    time.minute,
  );
  print('succes');
}catch(e){
  print('error:$e');
}
        Navigator.pushNamed(context, '/home');
      } else {
        print('User or user.uid is null. Unable to store reminder.');
        print('$user');
      }
    } catch (e) {
      print('Error storing reminder: $e');
    }
  }

  ///Scheduling the notifications using [flutter_local_notifications]

  Future<void> scheduleNotification(
      String task, String day, int hour, int minute) async {
    var androidDetails = const AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      channelDescription: 'Channel Description',
      importance: Importance.high,
      priority: Priority.high,
    );
    // var iOSDetails = InitializationSettingsDarwin;
    var platformChannelSpecifics =
    NotificationDetails(android: androidDetails,);

    // Convert DateTime to TZDateTime
    DateTime scheduledTime = DateTime.now().toLocal().add(
      Duration(hours: hour, minutes: minute),
    );
    var tzScheduledTime = tz.TZDateTime.from(scheduledTime, _local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Notification ID
      'Reminder: $task',
      'Scheduled for $day at ${formatTime(TimeOfDay(hour: hour, minute: minute))}',
      tzScheduledTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.dg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// Button to choose activity

            Container(
              padding: EdgeInsets.all(10.dg),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  width: 1.w,
                  color: Colors.orange
                )
              ),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none
                ),
                hint: const Text('Select Activity'),
                value: selectedActivity,
                onChanged: (value) {
                  setState(() {
                    selectedActivity = value.toString();
                  });
                },
                items: activities
                    .map((activity) => DropdownMenuItem(
                  value: activity,
                  child: Text(activity,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                ))
                    .toList(),
              ),
            ),
            SizedBox(height:30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Button to choose day for the reminder

                Container(
                  width: 200.w,
                  padding: EdgeInsets.all(10.dg),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                          width: 1,
                          color: Colors.orange
                      )
                  ),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    hint: const Text('Select Day'),
                    value: selectedDay,
                    onChanged: (value) {
                      setState(() {
                        selectedDay = value.toString();
                      });
                    },
                    items: [
                      'Monday',
                      'Tuesday',
                      'Wednesday',
                      'Thursday',
                      'Friday',
                      'Saturday',
                      'Sunday'
                    ]
                        .map((day) => DropdownMenuItem(
                              value: day,
                              child: Text(day,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                            ))
                        .toList(),
                  ),
                ),

                /// Button to choose time for the reminder

                GestureDetector(
                  onTap: () async {
                    TimeOfDay? newTime =
                    await showTimePicker(context: context, initialTime: time);
                    if (newTime == null) return;
                    setState(() {
                      time = newTime;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.dg),
                    height: 65.h,
                    width: 140.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(width: 1, color: Colors.orange)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatTime(time),
                          style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        const Icon(Icons.arrow_drop_down_rounded)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height:30.h),

            MyButton(
              title: 'Set Reminder',
              color: Colors.orange.shade300,
              onTap: () {
                _storeReminder();
              },
            )
          ],
        ),
      ),
    );
  }

  ///Function to convert the chosen time into string before uploading to firebase
  String formatTime(TimeOfDay time) {
    // Determine if it's AM or PM
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';

    // Format time as HH:mm AM/PM
    int hour = time.hourOfPeriod;
    return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
  }

}
