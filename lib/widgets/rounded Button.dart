import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Icon icon;
  final void Function()? onPressed;
  const RoundButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return   ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
         Colors.white,
        ),
        shape: MaterialStateProperty.all<CircleBorder>(
          CircleBorder(),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(60, 60),
        ),
      ),
      onPressed:onPressed,
      child: icon,
    );
  }
}
