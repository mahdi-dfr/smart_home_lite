import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/constants/utils.dart';
import '../../../../core/resource/connection_controller.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/entity/device_entity.dart';
import '../../domain/usecase/device_usecase.dart';

class DeviceController extends GetxController {
  DeviceUseCase _useCase;

  DeviceController(this._useCase);

  RxList<DeviceEntity> roomsList = RxList();

  var isLoading = false.obs;
  var isDeviceLoading = false.obs;
  var isDeleteDeviceLoading = false.obs;
  String? deviceType;
  String? nodeProject;
  int? roomId;

  RxList<DeviceEntity> deviceList = RxList();
  RxList<DeviceEntity> oneTimeDeviceList = RxList();

  Future<DataState<List<DeviceEntity>>> getAllDevises() async {
    isDeviceLoading.value = true;
    if (Get.find<ConnectionController>().isConnected.value) {
      DataState<List<DeviceEntity>> dataState = await _useCase.getDevices(
          GetStorage().read(AppUtils.projectIdConst), roomId!);
      if (dataState is DataSuccess) {
        if (dataState.data != null) {
          deviceList.value = dataState.data ?? [];
          isDeviceLoading.value = false;
        }
        return DataSuccess(dataState.data);
      } else {
        isDeviceLoading.value = false;
        return const DataFailed('err');
      }
    } else {
      isDeviceLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید!');
    }
  }

  filterDevicesBasedOnOneTime() {
    oneTimeDeviceList.clear();
    if (deviceList.isNotEmpty) {
      for (var element in deviceList) {
        if (element.deviceType == '0') {
          oneTimeDeviceList.add(element);
        }
      }
    }
  }
}
