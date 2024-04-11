import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/styles.dart';
import '../controller/device_controller.dart';
import '../widget/one_time_widget.dart';

class OneTimeDeviceScreen extends StatelessWidget {
  OneTimeDeviceScreen({Key? key}) : super(key: key);

  final _controller = Get.find<DeviceController>();
  late String projectName;
  late String username;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 50,
        foregroundColor: CustomColors.foregroundColor,
        backgroundColor: CustomColors.backgroundColor,
        title: Image.asset(
          Images.logoWide,
          width: width / 5,
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: Obx(() {
        return _controller.isDeviceLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Center(
                  child: _controller.deviceList.isEmpty
                      ? const Text(
                          'اطلاعاتی برای نمایش وجود ندارد!',
                          style: TextStyle(color: Colors.white),
                        )
                      : CustomScrollView(slivers: [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    Images.right,
                                    width: width / 3,
                                    color: CustomColors.foregroundColor,
                                  ),
                                  const Text(
                                    'کلیدهای تک تایمر',
                                    style: AppStyles.style13,
                                  ),
                                  SvgPicture.asset(
                                    Images.left,
                                    width: width / 3,
                                    color: CustomColors.foregroundColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverGrid.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 18,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return OneTimeWidget(
                                    title: _controller
                                        .oneTimeDeviceList[index].name,
                                    boardId: _controller.deviceList[index]
                                        .nodeProject?.boardProject,
                                    nodeId: _controller.deviceList[index]
                                        .nodeProject?.uniqueId,
                                    onPressed: () {});
                              },
                              itemCount: _controller.oneTimeDeviceList.length),
                        ]),
                ),
              );
      })),
    );
  }
}
