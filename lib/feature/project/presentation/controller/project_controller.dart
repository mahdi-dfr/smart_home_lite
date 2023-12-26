import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/resource/connection_controller.dart';
import '../../../../core/resource/data_state.dart';
import '../../data/model/response/project_model.dart';
import '../../domain/entity/project_entity.dart';
import '../../domain/usecase/project_usecase.dart';

class ProjectController extends GetxController{
  ProjectUseCase _useCase;

  ProjectController(this._useCase);

  late Map<String, dynamic> request;
  RxList<ProjectResults> projectList = RxList();

  var isLoading = false.obs;
  var isGetProjectsLoading = false.obs;
  var isDeleteLoading = false.obs;
  bool projectEditMode = false;
  int? projectId;

  @override
  void onInit() {
    getAllProjects();
    super.onInit();
  }

  Future<DataState<ProjectEntity>> getAllProjects() async {
    isGetProjectsLoading.value = true;
    // if (!Get
    //     .find<ConnectionController>()
    //     .isConnected
    //     .value) {
    //   isGetProjectsLoading.value = false;
    //   print('netttttttttttttttttttttttttttt');
    //   return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید!');
    // }
      DataState<ProjectEntity> dataState = await _useCase.getAllProjects();
      if (dataState is DataSuccess) {
        if (dataState.data != null) {
          projectList.value = dataState.data?.results ?? [];
        }
        isGetProjectsLoading.value = false;
        return DataSuccess(dataState.data);
      } else {
        return const DataFailed('err');
      }
  }

}