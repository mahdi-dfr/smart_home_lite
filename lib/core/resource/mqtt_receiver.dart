
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../feature/project/data/model/response/project_board_resault.dart';
import '../../feature/project/domain/entity/project_board_entity.dart';
import '../../feature/project/domain/usecase/project_usecase.dart';
import '../constants/utils.dart';
import 'connection_controller.dart';
import 'data_state.dart';
import 'mqtt_service.dart';

class MqttReceiver extends GetxController {

  ProjectUseCase _useCase;
  MqttReceiver(this._useCase);

  final _mqttController = Get.find<MqttService>();
  RxList<ProjectBoardResultsEntity>? boardList = RxList();
  String projectName = GetStorage().read(AppUtils.projectNameConst);
  String projectId = GetStorage().read(AppUtils.projectIdConst).toString();
  String username = GetStorage().read(AppUtils.username);
  var relayOneTime1 = ''.obs;
  List<ProjectBoardResultsEntity> relayList = [];
  int? relayCount;
  late String relayTopic;


  @override
  onInit() async {
    super.onInit();
    relayTopic = '$projectName/$username/relay_refresh';
    getAllProjectsBoardsForMessage('1', projectId).then((value){
      boardList?.value.forEach((element) {
        if(element.boardType == 4){
          relayList.add(element);
        }
      });
      relayCount = relayList.length;
      if(relayCount! > 0){
        _mqttController.publishMessage({'relay_nums': relayCount}, relayTopic);
      }
    });

  }


  Future<DataState<ProjectBoardEntity>> getAllProjectsBoardsForMessage(
      String page, String projectId) async {
    if (Get.find<ConnectionController>().isConnected.value) {
      DataState<ProjectBoardEntity> dataState =
      await _useCase.getAllProjectsBoard(page, projectId);
      if (dataState is DataSuccess) {
        if (dataState.data != null) {
          boardList?.value.addAll(dataState.data!.results ?? []);
        }
        return DataSuccess(dataState.data);
      } else {
        return const DataFailed('err');
      }
    } else {
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید!');
    }
  }


}
