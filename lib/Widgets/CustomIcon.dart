import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  IconData icon;

  CustomIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 35);
  }
}
