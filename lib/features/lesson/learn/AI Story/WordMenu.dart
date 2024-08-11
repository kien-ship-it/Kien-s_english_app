import 'package:flutter/material.dart';

class WordMenu extends StatelessWidget {
  final String selectedWord;
  final String wordMeaning;

  const WordMenu({super.key, required this.selectedWord, required this.wordMeaning});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF), // Set the bottom portion to white
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.0),
          topRight: Radius.circular(35.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 4,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              selectedWord.isNotEmpty
                  ? 'Word: ${selectedWord}'
                  : 'Click a word to view definition', // Default text
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
          if (selectedWord.isNotEmpty)
            Text(
              'Meaning: ${wordMeaning}',
              style: const TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
        ],
      ),
    );
  }
}