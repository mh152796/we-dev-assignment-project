abstract class BaseApiServices {

  Future<dynamic> getApi({required String url});

  Future<dynamic> postApi({required String url, dynamic data});


}