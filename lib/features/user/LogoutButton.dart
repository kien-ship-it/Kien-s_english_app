
import 'package:flutter/material.dart';


class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 145,),
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(100.0),
          onTap: () {
            // Handle log out action
            print("Log Out tapped");
            },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Log Out",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
              SizedBox(width: 6.0),
              Icon(Icons.logout, color: Colors.red, size: 17,),
            ],
          ),
        ),
      ),
    );
  }
}