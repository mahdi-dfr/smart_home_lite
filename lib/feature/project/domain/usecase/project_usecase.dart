
import '../../../../core/resource/data_state.dart';
import '../entity/project_board_entity.dart';
import '../entity/project_entity.dart';
import '../repository/project_repository.dart';

class ProjectUseCase{
  ProjectRepository _repository;

  ProjectUseCase(this._repository);

  Future<DataState<ProjectEntity>> getAllProjects(){
    return _repository.getUserProjects();
  }

  Future<DataState<ProjectBoardEntity>> getAllProjectsBoard(String page, String projectId){
    return _repository.getUserProjectsBoard(page, projectId);
  }


}