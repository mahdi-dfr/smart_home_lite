import '../../../../core/resource/data_state.dart';
import '../entity/room_response_entity.dart';
import '../repository/home_repository.dart';

class RoomUseCase {
  HomeRepository _repository;

  RoomUseCase(this._repository);

  Future<DataState<RoomResponseEntity>> getAllRooms(int projectId) {
    return _repository.getRooms(projectId);
  }
}
