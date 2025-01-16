

import 'package:e_commerce/helper/ColorsHelper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../helper/FontsHelper.dart';

class CountButton extends StatelessWidget {
  final Function? onPressedDown;
  final Function? onPressedUp;
  int minCount;
  int maxCount;
  int initialCount;
  double height;
  double width;
  CountButton({
    required this.onPressedDown,
    required this.onPressedUp,
    super.key,
    required this.minCount,
    required this.maxCount,
    required this.initialCount,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ColorsHelper.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 30,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorsHelper.gray300),
      ),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  if (initialCount > minCount) {
                    setState(() {
                      initialCount--;
                    });
                    onPressedDown!.call(initialCount);
                  }
                },
                icon: const Icon(
                  LucideIcons.minus,
                  color: ColorsHelper.black,
                  size: 15,
                ),
              ),
              Text(
                "$initialCount",
                style: FontsHelper.bodySmall(
                  weight: FontWeight.bold,
                  color: ColorsHelper.black,
                  height: 1,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (initialCount < maxCount) {
                    setState(() {
                      initialCount++;
                    });
                    onPressedUp!.call(initialCount);
                  }
                },
                icon: const Icon(
                  LucideIcons.plus,
                  color: ColorsHelper.black,
                  size: 15,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
