import 'package:dio/dio.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/api_provider.dart';
import '../model/login_reposnse.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiProvider _apiProvider;

  AuthRepositoryImpl(this._apiProvider);

  @override
  Future<DataState<UserEntity>> loginUser(
      String username, String password) async {
    var response = await _apiProvider.loginUser(username, password);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        UserEntity userEntity = LoginResponse.fromJson(response.data);
        return DataSuccess(userEntity);
      } else if (response.statusCode == 400) {
        return const DataFailed('نام کاربری یا رمز عبور اشتباه است');
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }
}
