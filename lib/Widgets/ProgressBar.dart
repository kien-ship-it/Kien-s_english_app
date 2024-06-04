import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.paddingProgressBar,
    required this.progressWidth,
    required this.progressValue,
    required this.backgroundColor,
    required this.progressColor,
    this.textDisplay = false,
  });

  final double paddingProgressBar;
  final double progressWidth;
  final double progressValue;
  final Color backgroundColor;
  final Color progressColor;
  final bool textDisplay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Container(
                height: 20.0,
                width: progressWidth * progressValue, // 40% width for example
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),

              if (textDisplay) Positioned(
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