import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/response/status.dart';

class ProductController extends GetxController{

  RxList productDataList = RxList();

  final fetchProductRxRequestStatus = Status.LOADING.obs;
  RxList storeDataList = RxList();
  void setProductRxRequestStatus(Status value) => fetchProductRxRequestStatus.value = value;



  Future<void> loadProduct() async {
    fetchProductRxRequestStatus(Status.LOADING);
     await rootBundle.loadString('assets/product_data/product.json').then((value){
       print("json.decode(value)json.decode(value)${json.decode(value)}");
      productDataList.addAll(json.decode(value));
      fetchProductRxRequestStatus(Status.COMPLETED);
         }).onError((error, stackTrace) {
           print("objectfkgmdffkkdf ${error.toString()}");
       fetchProductRxRequestStatus(Status.ERROR);
     });
  }

  @override
  void onInit() {
    print("created,,,,,,,,,,");
    loadProduct();
    super.onInit();
  }
}