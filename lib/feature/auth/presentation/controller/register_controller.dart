import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/utils.dart';
import '../../../../core/resource/connection_controller.dart';
import '../../../../core/resource/data_state.dart';
import '../../../../core/resource/error_handler.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/usecase/auth_usecase.dart';


class AuthController extends GetxController {
  var isLoading = false.obs;
  late TextEditingController loginUsername;
  late TextEditingController loginPassword;

  final AuthUseCase _usecase;

  AuthController(this._usecase);

  @override
  onInit(){
    super.onInit();
    loginUsername = TextEditingController();
    loginPassword = TextEditingController();
  }

  Future<DataState<UserEntity>> loginUser() async {
    isLoading.value = true;
    if (!Get.find<ConnectionController>().isConnected.value) {
      isLoading.value = false;
      return const DataFailed('لطفا از اتصال اینترنت خود اطمینان حاصل نمایید');
    }

      if(loginUsername.text.isEmpty || loginPassword.text.isEmpty){
        isLoading.value = false;
        return const DataFailed('لطفا ابتدا فیلد های خالی را تکمیل نمایید');
      }

        DataState<UserEntity> dataState =
        await _usecase.loginUser(loginUsername.text, loginPassword.text);
        if (dataState is DataSuccess) {
          if (dataState.data != null) {
            Get.offAllNamed(PagesRoutes.project);
            GetStorage().write(AppUtils.userTokenAccess, dataState.data!.access);
            GetStorage().write(AppUtils.userTokenRefresh, dataState.data!.refresh);
            GetStorage().write(AppUtils.username, loginUsername.text);

            isLoading.value = false;
            return DataSuccess(dataState.data);
          }
          return const DataFailed('خطا در دریافت اطلاعات');
        } else {
          isLoading.value = false;
          return DataFailed(errorConvertor(dataState.error!));
        }

  }


  @override
  void dispose() {
    loginPassword.dispose();
    loginUsername.dispose();
    super.dispose();
  }
}
