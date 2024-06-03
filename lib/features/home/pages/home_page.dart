import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:we_dev_assignment_project/features/home/controller/product_controller.dart';
import 'package:we_dev_assignment_project/resources/app_color/color.dart';
import 'package:we_dev_assignment_project/utils/text_style.dart';

import '../../../custom_widget/custom_horizontal_container.dart';
import '../../../custom_widget/dynamic_image.dart';
import '../../../data/response/status.dart';
import '../../../utils/responsive_size.dart';
import '../widget/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(height: 110,),
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
                           child: Padding(padding: const EdgeInsets.only(left: 10, right: 5, top: 8, bottom: 8),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [
                               Text(product['name'],
                                   maxLines: 2,
                                   overflow: TextOverflow.ellipsis,
                                   style: AppTextStyles.textStyleRoboto400.fontSize14.copyWith(color: AppColor.textBlackColor)),
                               RichText(
                                 text:   TextSpan(
                                   children: [
                                     if(product["regular_price"] != product["price"] && (product["regular_price"].isNotEmpty && product["price"].isNotEmpty))
                                       TextSpan(
                                         text: "\$ ${product["regular_price"]} ",
                                         style: AppTextStyles.textStyleRoboto400.fontSize14.copyWith(color: AppColor.regularPriceColor).decorationLineThrough,
                                       ),
                                     TextSpan(
                                       text: "\$${product["price"]}",
                                       style: AppTextStyles.textStyleRoboto700.copyWith(color: AppColor.textBlackColor),
                                     ),
                                   ],
                                 ),
                               ),
                               RatingBar.builder(
                                 initialRating: double.parse(product["average_rating"].toString()),
                                 minRating: 1,
                                 direction: Axis.horizontal,
                                 allowHalfRating: true,
                                 unratedColor: AppColor.emptyRatingColor,
                                 itemSize: 15,
                                 ignoreGestures: true,
                                 itemCount: 5,
                                  itemBuilder: (context, _) =>  Icon(
                                   Icons.star,
                                   color: AppColor.ratingColor,
                                 ),
                                 onRatingUpdate: (rating) {

                                 },
                               )
                             ],
                           )
                           ),
                         )
                        ],
                      ),
                    );
                  },
                ),
              Status.ERROR =>
                Text("Something went wrong...", style: AppTextStyles.textStyleRoboto700),
            }),
      ),
    );
  }
}
