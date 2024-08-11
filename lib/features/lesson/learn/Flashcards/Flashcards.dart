import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import '../../../../Widgets/ProgressBar.dart';
import '../../../../models/WordModel.dart';

class Flashcards extends StatefulWidget {
  final List<WordModel> listWordModel;

  const Flashcards({super.key, required this.listWordModel});

  @override
  _FlashcardsState createState() => _FlashcardsState();
}

class _FlashcardsState extends State<Flashcards> {
  late PageController _pageController;
  int currentIndex = 0;
  List<GlobalKey<FlipCardState>> cardKeys = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
    cardKeys = List.generate(widget.listWordModel.length, (_) => GlobalKey<FlipCardState>());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double paddingProgressBar = 30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF5F5),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 0, left: 30),
                  child: ProgressBar(
                    paddingProgressBar: 30,
                    progressValue: (currentIndex + 1) / widget.listWordModel.length,
                    progressWidth: (MediaQuery.of(context).size.width -
                        2 * paddingProgressBar -
                        30),
                    progressColor: const Color(0xFFEB6440),
                    backgroundColor: const Color(0xFFEED7CF),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.listWordModel.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
                        child: FlipCard(
                          key: cardKeys[index],
                          direction: FlipDirection.HORIZONTAL,
                          speed: 300,
                          front: Container(
                            alignment: Alignment.center,
                            width: (MediaQuery.of(context).size.width -
                                2 * paddingProgressBar),
                            height:
                            MediaQuery.of(context).size.height * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFFDEE2E2),
                            ),
                            child: Text(
                              widget.listWordModel[index].word,
                              style: const TextStyle(
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
                            height:
                            MediaQuery.of(context).size.height * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFFDEE2E2),
                            ),
                            child: Text(
                              widget.listWordModel[index].wordMeaning,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 30, right: 30, bottom: 25, top: 0),
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
                          if (currentIndex > 0) {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 50,
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
                          cardKeys[currentIndex].currentState?.toggleCard();
                        },
                      ),
                      const SizedBox(
                        height: 50,
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
                          if (currentIndex < widget.listWordModel.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 14,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.black, size: 30),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
