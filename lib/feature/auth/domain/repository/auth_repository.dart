import '../../../../core/resource/data_state.dart';
import '../entity/user_entity.dart';

abstract class AuthRepository {

  Future<DataState<UserEntity>> loginUser(String username, String password);
}
