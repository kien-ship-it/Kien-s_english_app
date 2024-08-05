import 'package:flutter/material.dart';

Widget myCustomBtn(
    {required Function onTap,
    required IconData icon,
    required Color color,
    Color? iconColor}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(35),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4), // Shadow color with opacity
          spreadRadius: 2, // Spread value
          blurRadius: 3, // Blur value
        ),
      ],
    ),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        fixedSize: MaterialStateProperty.all(const Size(60, 60)),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
      ),
      onPressed: () {
        onTap();
      },
      child: Icon(icon, size: 30, color: iconColor ?? Colors.black),
    ),
  );
}
