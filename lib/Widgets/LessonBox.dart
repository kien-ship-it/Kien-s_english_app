import 'package:english_app/models/LessonModel.dart';
import 'package:english_app/services/store.dart';
import 'package:flutter/material.dart';

class LessonBox extends StatefulWidget {
  final LessonModel lessonModel;
  final bool isDefaultLesson;
  final Function(LessonModel) onTapLesson;

  const LessonBox({
    super.key,
    required this.lessonModel,
    this.isDefaultLesson = false,
    required this.onTapLesson,
  });

  @override
  State<LessonBox> createState() => _LessonBoxState();
}

class _LessonBoxState extends State<LessonBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 197, // Set a fixed height for the container
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: 260,
                    child: Text(
                      widget.lessonModel.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                widget.isDefaultLesson ? const SizedBox() :
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
                        offset:
                            const Offset(0, 0.5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      widget.lessonModel.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.lessonModel.isFavorite
                          ? const Color(0xFFEB6440)
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        FireStore.updateIsFavoriteById(widget.lessonModel.id ?? "");
                        // widget.lessonModel.toggleFavorite();
                      });
                    },
                  )
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                width: 290, // Set the width to limit the length of each line
                child: Text(
                  widget.lessonModel.description,
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
                onPressed: () async {
                  widget.onTapLesson(widget.lessonModel);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    const Color(0xFFEB6440),
                  ),
                  fixedSize: WidgetStateProperty.all<Size>(
                    const Size(200.0, 45.0),
                  ),
                ),
                child: Text(
                  widget.isDefaultLesson ? "ADD" : "START",
                  style: const TextStyle(
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
