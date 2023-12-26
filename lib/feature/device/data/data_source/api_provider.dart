import 'package:dio/dio.dart';
import '../../../../../core/constants/url_constant.dart';
import 'aip_interseptor.dart';

class DeviceApiProvider {
  final Dio _dio = Dio();

  Future<dynamic> getDevices(int projectId, int room) async {
    _dio.interceptors.add(DeviceApiInterceptor());
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
