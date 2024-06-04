import 'package:english_app/Widgets/ProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class Flashcards extends StatefulWidget {
  const Flashcards({super.key});

  @override
  _FlashcardsState createState() => _FlashcardsState();
}

class _FlashcardsState extends State<Flashcards> {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    double paddingProgressBar = 30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF5F5),
        body: Stack(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 13, left: 30),
                  child: ProgressBar(
                    paddingProgressBar: 30,
                    progressValue: 4 / 24,
                    progressWidth: (MediaQuery.of(context).size.width -
                        2 * paddingProgressBar -
                        30),
                    progressColor: const Color(0xFFEB6440),
                    backgroundColor: const Color(0xFFEED7CF),
                  ),
                ),
                FlipCard(
                  key: cardKey,
                  direction: FlipDirection.HORIZONTAL,
                  speed: 300,
                  front: Container(
                    alignment: Alignment.center,
                    width: (MediaQuery.of(context).size.width -
                        2 * paddingProgressBar),
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xFFDEE2E2),
                    ),
                    child: const Text(
                      "Aberration",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  back: Container(
                    alignment: Alignment.center,
                    width: (MediaQuery.of(context).size.width -
                        2 * paddingProgressBar),
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xFFDEE2E2),
                    ),
                    child: const Text(
                      "Definition",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 30, right: 30, bottom: 25, top: 25),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange[100],
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 7.0,
                        offset: Offset(1, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {
                          // Implement your back button action here
                        },
                      ),
                      const SizedBox(
                        // Changed from VerticalDivider
                        height: 50, // Specify the height
                        child: VerticalDivider(
                          color: Colors.black54,
                          thickness: 2,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.flip,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {
                          cardKey.currentState?.toggleCard();
                        },
                      ),
                      const SizedBox(
                        // Changed from VerticalDivider
                        height: 50, // Specify the height
                        child: VerticalDivider(
                          color: Colors.black54,
                          thickness: 2,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {
                          // Implement your forward button action here
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 14,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black, size: 30),
              onPressed: () {
                Navigator.of(context).pop(context);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
