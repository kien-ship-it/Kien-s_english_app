import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.paddingProgressBar,
    required this.progressWidth,
    required this.progressValue,
  });

  final double paddingProgressBar;
  final double progressWidth;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 0, left: 35),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Progress: 17/20",
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: paddingProgressBar,
              right: paddingProgressBar,
              top: 8.0,
              bottom: 15),
          child: Stack(
            children: [
              Container(
                height: 20.0, // Thicker height for the progress bar
                decoration: BoxDecoration(
                  color: const Color(0xFFB1DCDF),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Container(
                height: 20.0,
                width: progressWidth * progressValue, // 40% width for example
                decoration: BoxDecoration(
                  color: const Color(0xFF497174),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Positioned(
                left: progressWidth * progressValue - 45, // Adjust the position for the text
                top: 0,
                child: Container(
                  width: 40,
                  height: 20,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      '${(progressValue * 100).toInt()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}