import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
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
          'Authorization': 'Bearer ',
          },
      body: data == null? null : jsonEncode(data)
      ).timeout(const Duration(seconds: 30));

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