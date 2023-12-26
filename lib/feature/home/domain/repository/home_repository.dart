import '../../../../core/resource/data_state.dart';
import '../entity/room_response_entity.dart';

abstract class HomeRepository {
  Future<DataState<RoomResponseEntity>> getRooms(int projectId);
}
