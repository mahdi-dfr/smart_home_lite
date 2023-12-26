import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/utils.dart';
import '../controller/project_controller.dart';
import '../widget/project_item.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen({Key? key}) : super(key: key);

  final _controller = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: height/10,
        automaticallyImplyLeading: true,
        backgroundColor: CustomColors.backgroundColor,
        title: SvgPicture.asset(Images.logoWide, width: width/5,),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Obx(() {
              return _controller.isGetProjectsLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                      ),
                      itemBuilder: (context, index) {
                        return ProjectItemWidget(
                          title:
                              _controller.projectList.value[index].name ?? '',
                          onClick: () async {
                            _controller.projectId =
                                _controller.projectList.value[index].id ?? 0;
                            GetStorage().write(
                                AppUtils.projectIdConst, _controller.projectId);

                            GetStorage().write(AppUtils.projectNameConst,
                                _controller.projectList.value[index].name);
                            Get.toNamed(PagesRoutes.home);
                            Get.delete<ProjectController>();
                          },
                        );
                      },
                      itemCount: _controller.projectList.value.length,
                    );
            })),
      ),
    );
  }
}
