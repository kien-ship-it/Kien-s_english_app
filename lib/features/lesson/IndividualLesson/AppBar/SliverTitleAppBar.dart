import 'package:english_app/features/lesson/LessonScreen.dart';
import 'package:flutter/material.dart';
import 'BackgroundWave.dart';

class SliverTitleAppBar extends SliverPersistentHeaderDelegate {
  final String title;

  SliverTitleAppBar({required this.title});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double topPadding = MediaQuery.of(context).padding.top + 16;

    // Calculate the scale for the title
    double titleScale = 1 - (shrinkOffset / maxExtent);
    double titleSize = 40.0 * titleScale.clamp(0.5, 1.0);
    double titleOffset = (40.0 * (1 - titleScale)).clamp(0.0, 20.0);

    // Calculate opacity for the description
    double descriptionOpacity = 1.0 - (shrinkOffset / minExtent).clamp(0.0, 1.0);

    return Stack(
      children: [
        const BackgroundWave(height: 200),
        Positioned(
          top: topPadding,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 40), // Reserve space for the title to be centered
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // Handle options action
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: topPadding + 40.0 - titleOffset - 8.5,
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2,),
                // AnimatedOpacity(
                //   duration: const Duration(milliseconds: 100),
                //   opacity: descriptionOpacity,
                //   child: const SizedBox(
                //     width: 280,
                //     child: Text(
                //       "1000 most common advanced SAT vocabulary",
                //       style: TextStyle(
                //         fontSize: 16.0,
                //         color: Colors.black87,
                //       ),
                //       textAlign: TextAlign.center,
                //
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 160;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
