import 'package:dio/dio.dart';
import '../../../../../core/constants/url_constant.dart';
import 'aip_interseptor.dart';

class ProjectApiProvider {
  final Dio _dio = Dio();

  /// get user projects
  Future<dynamic> getAllProjects() async {
    _dio.interceptors.add(ProjectApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.project,
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      return response;
    } catch (err) {
      if (err is DioException) {
        return err;
      }
    }
  }

  Future<dynamic> getAllProjectBoards(String page, String projectId) async {
    _dio.interceptors.add(ProjectApiInterceptor());
    try {
      var response = await _dio.get(
        UrlConstant.baseUrl + UrlConstant.projectBoard,
        queryParameters: {'project': projectId, 'page': page},
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
