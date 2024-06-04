import 'package:flutter/material.dart';

import '../../../models/WordModel.dart';

class WordBox extends StatelessWidget {
  final List<WordModel> words;

  const WordBox({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8.0),
          padding: const EdgeInsets.all(8.0),
          height: 450,
          // Fixed height for the box
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ScrollbarTheme(
            data: const ScrollbarThemeData(
              radius: Radius.circular(100),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 3,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: words.length, // Number of text lines
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(color: Colors.grey),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${words[index].word}: Definition ${words[index].wordMeaning}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -20, // Adjust position as needed
          left: (MediaQuery.of(context).size.width - 46) /
              2, // Adjust position to center
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xFFD9D9D9),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const Icon(
              Icons.edit,
              color: Colors.black,
              size: 26,
            ),
          ),
        ),
      ],
    );
  }
}
