import 'package:flutter/material.dart';

class LearnBox extends StatelessWidget {
  const LearnBox({
    super.key,
    required this.title,
    required this.icon,
    required this.distanceIconText,
    required this.color,
    required this.onTapAction,
  });

  final String title;
  final IconData icon;
  final double distanceIconText;
  final Color color;
  final Function onTapAction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTapAction();
        },
        child: Container(
          height: 155,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon, // Use your desired icon here
                size: 60.0,
                color: Colors.white,
              ),
              SizedBox(height: distanceIconText),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}