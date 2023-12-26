import '../../../../core/resource/data_state.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  Future<DataState<UserEntity>> loginUser(String username, String password){
    return _repository.loginUser(username, password);
  }

}
