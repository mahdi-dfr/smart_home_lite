import 'package:get/get.dart';
import 'package:turkeysh_light/core/resource/mqtt_service.dart';

import '../../feature/auth/data/data_source/api_provider.dart';
import '../../feature/auth/data/repository/auth_repository_impl.dart';
import '../../feature/auth/domain/repository/auth_repository.dart';
import '../../feature/auth/domain/usecase/auth_usecase.dart';
import '../../feature/auth/presentation/controller/register_controller.dart';
import '../../feature/device/data/data_source/api_provider.dart';
import '../../feature/device/data/repository/home_repository_impl.dart';
import '../../feature/device/domain/repository/home_repository.dart';
import '../../feature/device/domain/usecase/device_usecase.dart';
import '../../feature/device/presentation/controller/device_controller.dart';
import '../../feature/home/data/data_source/api_provider.dart';
import '../../feature/home/data/repository/home_repository_impl.dart';
import '../../feature/home/domain/repository/home_repository.dart';
import '../../feature/home/domain/usecase/room_usecase.dart';
import '../../feature/home/presentation/controller/room_controller.dart';
import '../../feature/project/data/data_source/api_provider.dart';
import '../../feature/project/data/repository/project_repository_impl.dart';
import '../../feature/project/domain/repository/project_repository.dart';
import '../../feature/project/domain/usecase/project_usecase.dart';
import '../../feature/project/presentation/controller/project_controller.dart';
import 'connection_controller.dart';
import 'mqtt_receiver.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    /// api providers:
    Get.put<AuthApiProvider>(AuthApiProvider());

    /// repositories:
    Get.put<AuthRepository>(AuthRepositoryImpl(Get.find<AuthApiProvider>()));

    ///useCase:
    Get.put<AuthUseCase>(AuthUseCase(Get.find<AuthRepository>()));

    /// controllers:
    Get.put(ConnectionController());
    Get.put(AuthController(Get.find<AuthUseCase>()));
  }
}

class ProjectBindings extends Bindings {
  @override
  void dependencies() {
    /// api providers:
    Get.put<ProjectApiProvider>(ProjectApiProvider());

    /// repositories:
    Get.put<ProjectRepository>(ProjectRepositoryImpl(Get.find<ProjectApiProvider>()));

    ///useCase:
    Get.put<ProjectUseCase>(ProjectUseCase(Get.find<ProjectRepository>()));

    /// controllers:
    Get.put(ProjectController(Get.find<ProjectUseCase>()));

  }
}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    /// api providers:
    Get.put<HomeApiProvider>(HomeApiProvider());
    Get.put<DeviceApiProvider>(DeviceApiProvider());

    /// repositories:
    Get.put<HomeRepository>(HomeRepositoryImpl(Get.find<HomeApiProvider>()));
    Get.put<DeviceRepository>(DeviceRepositoryImpl(Get.find<DeviceApiProvider>()));

    ///useCase:
    Get.put<RoomUseCase>(RoomUseCase(Get.find<HomeRepository>()));
    Get.put<DeviceUseCase>(DeviceUseCase(Get.find<DeviceRepository>()));

    /// controllers:
    Get.put(RoomController(Get.find<RoomUseCase>()));
    Get.put(DeviceController(Get.find<DeviceUseCase>()));
    Get.put(MqttService());
    Get.put(MqttReceiver(Get.find<ProjectUseCase>()));
  }
}
