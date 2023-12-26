import '../../../../core/resource/data_state.dart';
import '../entity/device_entity.dart';

abstract class DeviceRepository {
  Future<DataState<List<DeviceEntity>>> getDevice(int projectId, int room);
}
