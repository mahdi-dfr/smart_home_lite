import 'package:dio/dio.dart';

import '../../../../core/resource/data_state.dart';
import '../../domain/entity/room_response_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/api_provider.dart';
import '../model/room_response.dart';

class HomeRepositoryImpl extends HomeRepository {
  HomeApiProvider _apiProvider;

  HomeRepositoryImpl(this._apiProvider);

  @override
  Future<DataState<RoomResponseEntity>> getRooms(int projectId) async {
    var response = await _apiProvider.getProjectRoom(projectId);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        RoomResponseEntity entity = RoomResponseModel.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }
}
