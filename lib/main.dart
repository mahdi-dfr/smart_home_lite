import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/constants/routes.dart';
import 'core/constants/utils.dart';
import 'core/resource/app_bindings.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppBindings().dependencies();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      initialRoute: GetStorage().read(AppUtils.userTokenAccess) != null
          ? PagesRoutes.project
          : PagesRoutes.login,
      locale: const Locale('fa'),
      getPages: PagesRoutes.pages,
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      theme: ThemeData(
          fontFamily: 'IranSans',
          useMaterial3: true
      ),
    );
  }
}


