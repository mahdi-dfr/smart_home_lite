import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_light/core/constants/utils.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widget/logout_dialog.dart';
import '../../../device/presentation/controller/device_controller.dart';
import '../../../device/presentation/screen/one_time_devices.dart';
import '../controller/room_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height/10,
        automaticallyImplyLeading: true,
        foregroundColor: CustomColors.foregroundColor,
        backgroundColor: CustomColors.backgroundColor,
        title: Image.asset(Images.logoWide, width: width/5,),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: IconButton(
              icon: Icon(Icons.logout, color: CustomColors.foregroundColor,),
              onPressed: () {
                questionDialog(
                    title: 'خروج از حساب کاربری',
                    question: 'آیا میخواهید از حساب خود خارج شوید؟',
                    onYesClicked: () {
                      GetStorage().remove(AppUtils.userTokenAccess);
                      GetStorage().remove(AppUtils.userTokenRefresh);
                      Get.offAllNamed(PagesRoutes.login);
                    });
              },
            ),
          ),

        ],
      ),
        backgroundColor: CustomColors.backgroundColor,
        body: SafeArea(
          child: CustomScrollView(slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'اتاق ها',
                      style: AppStyles.style2,
                    )),
              ),
              GetBuilder<RoomController>(builder: (logic) {
                if (!logic.isLoading.value) {
                  return SizedBox(
                    height: height * 0.7,
                    width: width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            if (logic.roomsList[index].id != null) {
                              Get.find<DeviceController>().roomId =
                                  logic.roomsList[index].id;
                              Get.find<DeviceController>().getAllDevises().then((value){
                                Get.find<DeviceController>().filterDevicesBasedOnOneTime();
                              });
                              Get.to(() => OneTimeDeviceScreen());
                              Get.delete<RoomController>();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            width: width / 3,
                            height: height * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.borderRadius),
                                color: CustomColors.foregroundColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(12),
                                    width: width * 0.25,
                                    height: height * 0.4,
                                    decoration: BoxDecoration(
                                        color: CustomColors.itemColor,
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(
                                                AppDimensions.borderRadius),
                                            bottomLeft: Radius.circular(
                                                AppDimensions.borderRadius))),
                                    child: SvgPicture.asset(Images.logo,)),
                                Text(
                                  logic.roomsList[index].name ?? '',
                                  style: AppStyles.style11,
                                ),
                                const SizedBox()
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: logic.roomsList.length,
                    ),
                  );
                } else {
                  return SizedBox(
                    width: width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
            ]))
          ]),
        ));
  }
}
