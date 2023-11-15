import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/reminder_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  User? user = FirebaseAuth.instance.currentUser;
  String task = '';
  String day = '';
  String hour = '';
  String minute = '';
  String amPm = '';

  Future<void> _fetchUserData() async {
    try {
      // Fetch data from Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('User Reminder')
              .doc(user?.uid)
              .collection('Reminders')
              .get();

      // Check if there is at least one document in the collection
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming you want to use the first document in the collection
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            querySnapshot.docs.first;

        Map<String, dynamic> userTask = documentSnapshot.data()!;

        setState(() {
          task = userTask['Task'] ?? "";
          day = userTask['Day'] ?? '';
          hour = userTask['Hour'] ?? '';
          minute = userTask['Minute'] ?? '';
          amPm =
              userTask['AM/PM'] ?? ''; // Assuming 'AmPm' is the correct field
        });

        // Set the username to the controller
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void deleteReminder(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection("User Reminder")
          .doc(user!.uid)
          .collection("Reminders")
          .doc(documentId)
          .delete();

      print("Document deleted successfully!");
    } catch (e) {
      print("Error deleting document: $e");
    }
  }

  @override
  void initState() {
    _fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("R E M I N D E R"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('User Reminder')
                    .doc(user?.uid)
                    .collection("Reminders")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final reminder = snapshot.data!.docs[index];
                          final reminderData =
                              reminder.data() as Map<String, dynamic>;
                          return ReminderTile(
                            onPressed: () {
                              deleteReminder(reminder.id);
                            },
                            task: reminderData['Task'] ?? "",
                            time:
                                "${reminderData['Hour']} : ${reminderData['Minute']} ${reminderData['AM/PM']}",
                          );
                        });
                  } else {
                    return Center(
                        child:
                            Container(
                                padding: EdgeInsets.all(20.dg),
                                child: CircularProgressIndicator()));
                  }
                }),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/add_reminder');
            },
            child: Padding(
              padding:  EdgeInsets.only(bottom: 15.h),
              child: Container(
                  height: 60.h,
                  width: 60.w,
                  padding: EdgeInsets.all(10.dg),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30.sp,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
