import '../../../../core/resource/data_state.dart';
import '../entity/project_board_entity.dart';
import '../entity/project_entity.dart';

abstract class ProjectRepository{

  Future<DataState<ProjectEntity>> getUserProjects();

  Future<DataState<ProjectBoardEntity>> getUserProjectsBoard(String page, String projectId);


}