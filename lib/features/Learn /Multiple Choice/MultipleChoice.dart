import 'package:flutter/material.dart';
import '../../../Widgets/ProgressBar.dart';

class MultipleChoice extends StatefulWidget {
  const MultipleChoice({super.key});

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  int? _selectedIndex;
  bool _isCheckButtonHighlighted = false;

  void _onOptionTapped(int index) {
    setState(() {
      if (_selectedIndex == index) {
        _selectedIndex = null;
        _isCheckButtonHighlighted = false;
      } else {
        _selectedIndex = index;
        _isCheckButtonHighlighted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double paddingProgressBar = 30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF5F5),
        body: Stack(
          children: [
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 13, left: 30),
                  child: ProgressBar(
                    paddingProgressBar: 30,
                    progressValue: 4 / 24,
                    progressWidth: (MediaQuery.of(context).size.width - 2 * paddingProgressBar - 30),
                    progressColor: const Color(0xFFEB6440),
                    backgroundColor: const Color(0xFFEED7CF),
                  ),
                ),
                const SizedBox(height: 40), // Add some space between ProgressBar and text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Which word means",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black54,
                  indent: 30,
                  endIndent: 30,
                ),
                const SizedBox(height: 10), // Add some space between Divider and bold text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "A departure from what is normal, usual, or expected, typically one that is unwelcome.",
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 42),
                 SingleChoice(
                  title: "Aberration",
                  isSelected: _selectedIndex == 0,
                  onTap: () => _onOptionTapped(0),
                ),
                 SingleChoice(
                  title: "Collaborative",
                  isSelected: _selectedIndex == 1,
                  onTap: () => _onOptionTapped(1)
                 ),
                SingleChoice(
                    title: "Explore",
                    isSelected: _selectedIndex == 2,
                    onTap: () => _onOptionTapped(2),
                ),
                SingleChoice(
                    title: "Contemplate",
                    isSelected: _selectedIndex == 3,
                    onTap: () => _onOptionTapped(3),
                )
              ],
            ),
            Positioned(
              bottom: 30,
              left: 30,
              right: 30,
              child: Container(
                height: 60,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: _isCheckButtonHighlighted ? const Color(0xFFEB6440) : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: Colors.grey.shade400, width: 1.5),
                  boxShadow: [
                    if (_isCheckButtonHighlighted)
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 0,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      )
                  ],
                ),
                child:  Center(
                  child: Text(
                    "CHECK",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _isCheckButtonHighlighted ? Colors.white : Colors.grey,
                    ),
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

class SingleChoice extends StatelessWidget {
  const SingleChoice({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEED7CF) : const Color(0xFFEFF5F5),
          borderRadius: BorderRadius.circular(10),
          border: isSelected ?
                  Border.all(color: Colors.orangeAccent, width: 1.5):
                  Border.all(color: Colors.grey.shade400, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
