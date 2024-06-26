import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:we_dev_assignment_project/features/home/widget/filter_pop_up.dart';
import '../../../data/response/status.dart';
import '../../../resources/app_color/color.dart';
import '../../../utils/text_style.dart';

class ProductController extends GetxController {

  RxList productDataList = RxList();
  RxString filterKey = "".obs;
  final fetchProductRxRequestStatus = Status.LOADING.obs;
  RxList storeDataList = RxList();


  Future<void> filterDialog({required BuildContext context}) async {
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
          return  FilterPopUp();
        });
  }


  RxList filterItems = RxList( [
    {"name": "Newest", "slug" : "newest", "isChecked": false},
    {"name": "Oldest", "slug" : "oldest", "isChecked": false},
    {"name": "Price low > High", "slug" : "ascending", "isChecked": false},
    {"name": "Price high > Low", "slug" : "descending", "isChecked": false},
    {"name": "Best selling", "slug" : "best-sell", "isChecked": false},
  ]);

  void setProductRxRequestStatus(Status value) => fetchProductRxRequestStatus.value = value;

  Future<void> loadProduct() async {
    fetchProductRxRequestStatus(Status.LOADING);
    await rootBundle
        .loadString('assets/product_data/product.json')
        .then((value) {
      productDataList.addAll(json.decode(value));
      fetchProductRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackTrace) {
      fetchProductRxRequestStatus(Status.ERROR);
    });
  }

  void checkChanged({required int index, bool? isChecked}){
    for(var v in filterItems){
      v["isChecked"] = false;
    }
    if(isChecked == null){
      filterItems.refresh();
      return;
    }
    filterItems[index]["isChecked"] = isChecked;
    filterItems.refresh();
  }

  void sort() {
    if(filterKey.value == "Price low > High" || filterKey == "Price high > Low"){
      sortByPrice();
    }
  }

  void sortByPrice() {
    print("created,,,,,,,,,,");

    productDataList.sort((a, b) => filterKey == "Price low > High"
        ? int.parse(a['price'].toString()).compareTo(int.parse(b['price'].toString()))
        : int.parse(b['price']).compareTo(int.parse(a['price'])));
    productDataList.refresh();
  }

  @override
  void onInit() {
    loadProduct();
    super.onInit();
  }
}
