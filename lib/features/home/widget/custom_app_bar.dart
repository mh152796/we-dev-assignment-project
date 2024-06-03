import 'package:flutter/material.dart';
import 'package:we_dev_assignment_project/custom_widget/custom_horizontal_container.dart';
import 'package:we_dev_assignment_project/resources/app_color/color.dart';

import '../../../utils/text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: AppColor.scaffoldColor,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Text(
                "Product List",
                style: AppTextStyles.textStyleRoboto700,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 25,
                    color: AppColor.blackColor,
                  )),
            ],
          ),
          CustomHorizontalContainer(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.rotate(
                      angle: -90 * 3.1415927 / 180,
                      // Rotate 90 degrees counter-clockwise
                      child: Icon(
                        Icons.tune,
                        size: 20,
                        color: AppColor.filterIconColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Filter",
                      style: AppTextStyles.textStyleRoboto400
                          .setColor(
                            AppColor.filterTextColor,
                          )
                          .setFontSize(14),
                    )
                  ],
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Sort by",
                      style: AppTextStyles.textStyleRoboto400
                          .setColor(
                            AppColor.filterTextColor,
                          )
                          .setFontSize(14),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: AppColor.filterTextColor,),
                    const SizedBox(width: 8,),
                    Icon(Icons.menu, color: AppColor.blackColor,),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(50, height);
}
