import '../../../../core/resource/data_state.dart';
import '../entity/device_entity.dart';
import '../repository/home_repository.dart';

class DeviceUseCase {
  final DeviceRepository _repository;

  DeviceUseCase(this._repository);

  Future<DataState<List<DeviceEntity>>> getDevices(int projectId, int room) {
    return _repository.getDevice(projectId, room);
  }
}
