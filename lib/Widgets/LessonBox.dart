import 'package:flutter/material.dart';

class LessonBox extends StatelessWidget {
  final String boxTitle;
  final String boxDescription;
  final Color lessonBoxColor;
  final bool lightning;
  final Function? onTap;

  const LessonBox({
    super.key,
    required this.boxTitle,
    required this.boxDescription,
    required this.lessonBoxColor,
    required this.lightning,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8, bottom: 8),
      child: Container(
        height: 197, // Set a fixed height for the container
        decoration: BoxDecoration(
          // color: const Color(0xFFBFDEE2),
          color: lessonBoxColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    boxTitle,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 0.5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Icon(Icons.flash_on, color: lightning ? const Color(0xFFEB6440) : Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                width: 290, // Set the width to limit the length of each line
                child: Text(
                  boxDescription,
                  style: const TextStyle(fontSize: 16.0),
                  overflow: TextOverflow.ellipsis,
                  // Display ellipsis (...) if the text overflows
                  maxLines: 2, // Limit to 2 lines
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (onTap != null) {
                    onTap!();
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(const Color(0xFFEB6440)),
                  fixedSize:
                      WidgetStateProperty.all<Size>(const Size(200.0, 45.0)),
                ),
                child: const Text(
                  "START",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
