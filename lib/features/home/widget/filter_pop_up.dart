import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/app_color/color.dart';
import '../../../utils/text_style.dart';
import '../controller/product_controller.dart';

class FilterPopUp extends StatelessWidget {
    FilterPopUp({super.key});

  final _productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bottomSheetBgColor,
      height: 400,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xffFFD3DD),
                        borderRadius: BorderRadius.circular(10)),
                    width: 80,
                    height: 6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: Text(
                    "Filter",
                    style: AppTextStyles.textStyleRoboto700
                        .setColor(AppColor.blackColor)
                        .fontWeightBold
                        .setFontSize(18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Obx(() => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                    _productController.filterItems.length,
                    itemBuilder: (context, index) =>
                        buildCheckBoxRow(
                            label: _productController
                                .filterItems[index]["name"],
                            value: _productController
                                .filterItems[index]["isChecked"],
                            onPressed: (bool? value) {
                              if (value != null) {
                                final filterItemName = _productController.filterItems[index]["name"];
                                final hasFilterDisable = filterItemName == "Newest" || filterItemName == "Oldest" || filterItemName == "Best selling";
                                if(hasFilterDisable){
                                  return;
                                }
                                _productController.filterKey.value = _productController.filterItems[index]["name"];
                                _productController.checkChanged(index: index, isChecked: value);
                              }
                            }),
                  )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: LayoutBuilder(
                builder: (context, constraints) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                constraints.maxWidth * .45, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10)),
                            backgroundColor: AppColor.whiteColor,
                            side: const BorderSide(
                                color: Color(0xffD2DBE0),
                                width: 1)),
                        onPressed: () {
                          _productController.filterKey.value = "";
                          _productController.checkChanged(index: 0);
                          Get.back();
                        },
                        child: Text(
                          "Cancel",
                          style: AppTextStyles.textStyleRoboto700
                              .setColor(const Color(0xff818995)),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                constraints.maxWidth * .45, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10)),
                            backgroundColor:
                            AppColor.bottomSheetApplyBtnColor),
                        onPressed: () {
                          _productController.sort();
                          Get.back();
                        },
                        child: Text(
                          "Apply",
                          style: AppTextStyles.textStyleRoboto700
                              .setColor(AppColor.whiteColor),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

    Widget buildCheckBoxRow(
        {required String label,
          required ValueChanged<bool?> onPressed,
          bool? value}) {
      return Row(
        children: [
          Checkbox(
            value: label == "Newest" || label == "Oldest" || label == "Best selling"? false : value,
            activeColor: AppColor.checkBoxColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(
                width: 2.0,
                color: label == "Newest" || label == "Oldest" || label == "Best selling"? Colors.grey :AppColor.checkBoxColor,
              ),
            ),
            onChanged: onPressed,
          ),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.textStyleRoboto400.setFontSize(15).setColor(label == "Newest" || label == "Oldest" || label == "Best selling"? Colors.grey : AppColor.blackColor),
            ),
          ),
        ],
      );
    }
}
