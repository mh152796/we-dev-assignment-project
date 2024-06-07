import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:we_dev_assignment_project/features/auth/controller/auth_controller.dart';
import '../app_exception.dart';
import 'base_api_services.dart';
import 'package:http/http.dart' as http;
const String bearerToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiOTc2MCIsInJvbGUiOjEsImlhdCI6MTY3Njg3NjI3OH0.Ll1915AVcmLzRJ473jyjWo_1NIWxneFMVA8OCcWRp4k";
class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi({required String url}) async{
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson ;

    dynamic headers =  {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer '

    };

    try{
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      ).timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);

    }on SocketException {
      throw InternetException('');
    }on RequestTimeOut{
      throw RequestTimeOut('');
    }
    catch (e){
      rethrow;
    }

    if (kDebugMode) {
      print(responseJson);
    }

    return responseJson ;
  }


  @override
  Future<dynamic> postApi({required String url, data}) async{

    if (kDebugMode) {
      print("url url ${url.toString()}");
      print("dattatatatat ${data.toString()}");
    }

    dynamic responseJson ;
    try{

      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: data == null? null : jsonEncode(data)
      ).timeout(const Duration(seconds: 30));
      print("dfgcdshgfsdgsd ${response.body}");
      responseJson = returnResponse(response);

    }on SocketException {
      throw InternetException('');
    }on RequestTimeOut {
      throw RequestTimeOut('');
    } catch (e){
      rethrow;
    }

    if (kDebugMode) {
      print(responseJson);
    }

    return responseJson;

  }


  @override
  Future<dynamic> putApi({required String url, data}) async{
    final authController = Get.find<AuthController>();
    if (kDebugMode) {
      print("dattatatatat ${data.toString()}");
    }

    dynamic responseJson ;
    try{

      final response = await http.put(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${authController.authToken}',
          },
          body: data == null? null : jsonEncode(data)
      ).timeout(const Duration(seconds: 30));
      print("responsssssssssssssss ${jsonDecode(response.body)}");
      responseJson = returnResponse(response);

    }on SocketException {
      throw InternetException('');
    }on RequestTimeOut {
      throw RequestTimeOut('');
    } catch (e){
      rethrow;
    }

    if (kDebugMode) {
      print(responseJson);
    }

    return responseJson;

  }




  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200 || 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw "somethings went wrong ${response.statusCode}";
      case 404:
        throw "Not Found ${response.statusCode}";
      default:
        throw FetchDataException('Error accorded while communication with server ${response.statusCode}');
    }
  }

}