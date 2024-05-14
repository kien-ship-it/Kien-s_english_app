import 'package:flutter/material.dart';

class LessonBox extends StatelessWidget {
  const LessonBox({
    // required this.boxTitle,
    // required this.boxDescription,
    // required this.lessonBoxColor,
    // required this.lightning,
    super.key,
  });

  // String boxTitle;
  // String boxDescription;
  // Color lessonBoxColor;
  // bool lightning;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8, bottom: 8),
      child: Container(
        height: 200, // Set a fixed height for the container
        decoration: BoxDecoration(
          color: const Color(0xFFBFDEE2),
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "SAT 1000+",
                    style: TextStyle(
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
                        offset:  Offset(0, 0.5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Icon(Icons.flash_on, color: Color(0xFFEB6440)),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: SizedBox(
                width: 290, // Set the width to limit the length of each line
                child: Text(
                  "1000 most common SAT advanced SAT vocabulary",
                  style: TextStyle(fontSize: 16.0),
                  overflow: TextOverflow.ellipsis, // Display ellipsis (...) if the text overflows
                  maxLines: 2, // Limit to 2 lines
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFEB6440)),
                  fixedSize: MaterialStateProperty.all<Size>(const Size(200.0, 45.0)),
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