import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:reminder/widgets/my_textfields.dart';
import 'package:reminder/widgets/rounded%20Button.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _nameController = TextEditingController();

  ///Function to store the name
  _storename() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .add({'u_name': _nameController.text});
  }

  ///No credentials is taken, just letting the user login anonymously by calling the function
  Future<void> signInAnonymously() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInAnonymously();
      User? user = userCredential.user;
      print('Signed in anonymously: ${user?.uid}');
    } catch (e) {
      print('Error signing in anonymously: $e');
    }
  }

  ///To call the both functions, skipping and storing the database
  void _onClick() async {
    try {
      await _storename();
      await signInAnonymously();
      Navigator.pushNamed(context, '/home');
      print('Success');
    } catch (e) {
      print('Error in _onClick: $e');
      // Handle the error as needed
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.dg),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ///Animated json file is added using Lottie package

            SizedBox(
                height: 500.h,
                width: 200.w,
                child: Lottie.asset('assets/lottie/intro.json',
                    fit: BoxFit.contain)),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Your go-to organizer. Ready to kickstart productivity? Let's begin!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            MyTextField(
                hintText: 'Your Name',
                obscureText: false,
                controller: _nameController),
            SizedBox(
              height: 30.h,
            ),
            RoundButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {
                ///The name entered is added to the Firestore database
                _onClick();
              },
            )
          ],
        ),
      ),
    );
  }
}
