import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:we_dev_assignment_project/features/home/controller/product_controller.dart';
import 'package:we_dev_assignment_project/resources/app_color/color.dart';
import 'package:we_dev_assignment_project/utils/text_style.dart';
import '../../../custom_widget/dynamic_image.dart';
import '../../../data/response/status.dart';
import '../../../utils/responsive_size.dart';
import '../widget/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: 110,
          onPressed: () {
            showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                // backgroundColor: AppColor.bottomSheetBgColor,
                enableDrag: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                builder: (BuildContext context) {
                  return Container(
                    color: AppColor.bottomSheetBgColor,
                    height: 350,
                    width: double.infinity,
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
                  );
                });
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(() =>
              switch (_productController.fetchProductRxRequestStatus.value) {
                Status.LOADING => const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                Status.COMPLETED => GridView.builder(
                    itemCount: _productController.productDataList.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: context.convertToResponsiveSize(180),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: context.convertToResponsiveSize(260),
                    ),
                    itemBuilder: (context, index) {
                      final product = _productController.productDataList[index];

                      return Container(
                        decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.productCardShadowColor
                                    .withOpacity(.13),
                                offset: const Offset(1, 2),
                                blurRadius: 5,
                                spreadRadius: 0,
                              )
                            ]),
                        width: context.convertToResponsiveSize(180),
                        height: context.convertToResponsiveSize(260),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 5,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: DynamicNetworkImage(
                                  imageUrl: product['store']['avatar'],
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 5, top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(product['name'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyles
                                              .textStyleRoboto400.fontSize14
                                              .copyWith(
                                                  color:
                                                      AppColor.textBlackColor)),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            if (product["regular_price"] !=
                                                    product["price"] &&
                                                (product["regular_price"]
                                                        .isNotEmpty &&
                                                    product["price"]
                                                        .isNotEmpty))
                                              TextSpan(
                                                text:
                                                    "\$ ${product["regular_price"]} ",
                                                style: AppTextStyles
                                                    .textStyleRoboto400
                                                    .fontSize14
                                                    .copyWith(
                                                        color: AppColor
                                                            .regularPriceColor)
                                                    .decorationLineThrough,
                                              ),
                                            TextSpan(
                                              text: "\$${product["price"]}",
                                              style: AppTextStyles
                                                  .textStyleRoboto700
                                                  .copyWith(
                                                      color: AppColor
                                                          .textBlackColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      RatingBar.builder(
                                        initialRating: double.parse(
                                            product["average_rating"]
                                                .toString()),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        unratedColor: AppColor.emptyRatingColor,
                                        itemSize: 15,
                                        ignoreGestures: true,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: AppColor.ratingColor,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                Status.ERROR => Text("Something went wrong...",
                    style: AppTextStyles.textStyleRoboto700),
              }),
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
