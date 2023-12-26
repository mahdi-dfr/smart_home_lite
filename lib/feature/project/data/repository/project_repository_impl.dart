import 'package:dio/dio.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/entity/project_board_entity.dart';
import '../../domain/entity/project_entity.dart';
import '../../domain/repository/project_repository.dart';
import '../data_source/api_provider.dart';
import '../model/response/project_board.dart';
import '../model/response/project_model.dart';

class ProjectRepositoryImpl extends ProjectRepository{

  ProjectApiProvider _apiProvider;

  ProjectRepositoryImpl(this._apiProvider);

  @override
  Future<DataState<ProjectEntity>> getUserProjects() async {
      var response = await _apiProvider.getAllProjects();
      if (response is! DioException) {
        if (response.statusCode == 200) {
          ProjectEntity entity = ProjectResponseModel.fromJson(response.data);
          return DataSuccess(entity);
        } else {
          return DataFailed(response.statusCode);
        }
      } else {
        return DataFailed(response.response.toString());
      }
  }

  @override
  Future<DataState<ProjectBoardEntity>> getUserProjectsBoard(
      String page, String projectId) async {
    var response = await _apiProvider.getAllProjectBoards(page, projectId);
    if (response is! DioException) {
      if (response.statusCode == 200) {
        ProjectBoardEntity entity = ProjectBoard.fromJson(response.data);
        return DataSuccess(entity);
      } else {
        return DataFailed(response.statusCode);
      }
    } else {
      return DataFailed(response.response.toString());
    }
  }

}