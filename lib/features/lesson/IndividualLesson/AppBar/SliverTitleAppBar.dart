import 'package:english_app/services/store.dart';
import 'package:flutter/material.dart';

import '../../../../Widgets/ConfirmDialog.dart';
import '../../../../Widgets/MyToast.dart';
import 'BackgroundWave.dart';

class SliverTitleAppBar extends SliverPersistentHeaderDelegate {
  final String title;
  final String id;

  SliverTitleAppBar({required this.title, required this.id});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double topPadding = MediaQuery.of(context).padding.top + 16;

    // Calculate the scale for the title
    double titleScale = 1 - (shrinkOffset / maxExtent);
    double titleSize = 35.0 * titleScale.clamp(0.5, 1.0);
    double titleOffset = (40.0 * (1 - titleScale)).clamp(0.0, 20.0);

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
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              const SizedBox(width: 40),
              // Reserve space for the title to be centered
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                onPressed: () {
                  // show confirm dialog
                  showDialog(
                    context: context,
                    builder: (context) => ConfirmDialog(
                      confirmFunction: () async {
                        // Handle options action
                        FireStore.removeLessonById(id).then(
                          (value) {
                            if (value) {
                              Navigator.pop(context);
                            } else {
                              showToast("Something went wrong");
                            }
                          },
                        );
                      },
                    ),
                  );
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
                const SizedBox(
                  height: 2,
                ),
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
