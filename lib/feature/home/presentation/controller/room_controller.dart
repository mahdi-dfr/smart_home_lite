import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/constants/utils.dart';
import '../../../../core/resource/data_state.dart';
import '../../data/model/room_response.dart';
import '../../domain/entity/room_response_entity.dart';
import '../../domain/usecase/room_usecase.dart';

class RoomController extends GetxController {
  RoomUseCase _useCase;

  RoomController(this._useCase);

  RxList<RoomResults> roomsList = RxList();

  var isLoading = false.obs;
  int? roomId;

  @override
  void onInit() {
    getAllRooms(GetStorage().read(AppUtils.projectIdConst));
    super.onInit();
  }

  Future<DataState<RoomResponseEntity>> getAllRooms(int projectId) async {
    isLoading.value = true;
    DataState<RoomResponseEntity> dataState =
        await _useCase.getAllRooms(projectId);
    if (dataState is DataSuccess) {
      if (dataState.data != null) {
        roomsList.value = dataState.data?.results ?? [];
        isLoading.value = false;
        update();
      }
      return DataSuccess(dataState.data);
    } else {
      return const DataFailed('err');
    }
  }
}
