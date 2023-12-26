

import '../../data/model/response/project_board_resault.dart';

class ProjectBoardEntity {
  int? count;
  String? next;
  String? previous;
  List<ProjectBoardResultsEntity>? results;

  ProjectBoardEntity({this.count, this.next, this.previous, this.results});
}