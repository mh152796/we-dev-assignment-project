abstract class BaseApiServices {

  Future<dynamic> getApi({required String url});

  Future<dynamic> postApi({required String url, dynamic data});
  Future<dynamic> putApi({required String url, dynamic data});
}