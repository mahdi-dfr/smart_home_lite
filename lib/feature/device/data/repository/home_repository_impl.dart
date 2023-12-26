import 'package:dio/dio.dart';

import '../../../../core/resource/data_state.dart';
import '../../domain/entity/device_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/api_provider.dart';
import '../model/device.dart';

class DeviceRepositoryImpl extends DeviceRepository {
  DeviceApiProvider _apiProvider;

  DeviceRepositoryImpl(this._apiProvider);

  @override
  Future<DataState<List<DeviceEntity>>> getDevice(
      int projectId, int room) async {
    var response = await _apiProvider.getDevices(projectId, room);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        List<DeviceEntity> dataList = [];
        for (int i = 0; i < response.data.length; i++) {
          dataList.add(DeviceModel.fromJson(response.data[i]));
        }
        return DataSuccess(dataList);
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

}
