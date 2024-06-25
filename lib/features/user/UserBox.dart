import 'package:english_app/models/UserModel.dart';
import 'package:flutter/material.dart';

class UserBox extends StatelessWidget {
  final UserModel userModel;

  const UserBox({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 43,
            backgroundColor: Colors.amber,
            backgroundImage: NetworkImage(
                'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg'),
          ),
          const SizedBox(width: 20),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel.fullName,
                  style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 0),
                Text(
                  userModel.email,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.zero,
                      child: TextButton(
                        onPressed: null,
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft),
                        child: const Text(
                          "Edit profile",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.grey),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
