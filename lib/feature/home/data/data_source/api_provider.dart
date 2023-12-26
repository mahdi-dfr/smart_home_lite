import 'package:dio/dio.dart';
import '../../../../../core/constants/url_constant.dart';
import 'aip_interseptor.dart';

class HomeApiProvider {
  final Dio _dio = Dio();

  /// get project room
  Future<dynamic> getProjectRoom(int projectId) async {
    _dio.interceptors.add(HomeApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.room,
        queryParameters: {'project': projectId},
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }


  Future<dynamic> getDevices(int projectId, int room) async {
    _dio.interceptors.add(HomeApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.device,
        queryParameters: {'project': projectId, 'room': room},
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }



}
