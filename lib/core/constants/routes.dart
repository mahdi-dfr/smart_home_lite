import 'package:get/get.dart';

import '../../feature/auth/presentation/screen/login.dart';
import '../../feature/home/presentation/screen/home_page.dart';
import '../../feature/project/presentation/screen/project_screen.dart';
import '../resource/app_bindings.dart';

class PagesRoutes {
  PagesRoutes._();

  static const String _login = '/';
  static const String _project = '/project';
  static const String _home = '/home';
  static const String _createRoom = '/create_room';
  static const String _viewRoom = '/view_room';
  static const String _boardSetting = '/board_Setting';
  static const String _createBoard = '/create_board';
  static const String _createDevice = '/create_device';

  static String get boardSetting => _boardSetting;

  static String get login => _login;

  static String get project => _project;

  static String get home => _home;

  static String get viewRoom => _viewRoom;

  static String get createRoom => _createRoom;

  static String get createBoard => _createBoard;

  static String get createDevice => _createDevice;

  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: _login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: _project,
      page: () => ProjectScreen(),
      binding: ProjectBindings(),
    ),
    GetPage(
      name: _home,
      page: () => const HomePage(),
      binding: HomeBindings()
    ),

  ];
}
