// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../core/constants/colors.dart';
// import '../../../../core/constants/images.dart';
// import '../../../../core/constants/routes.dart';
// import '../../../../core/constants/styles.dart';
// import '../../../home/data/model/room_response.dart';
// import '../../../home/presentation/widget/devices/sensors_widget.dart';
// import '../controller/device_controller.dart';
//
// class DeviceListScreen extends StatelessWidget {
//   DeviceListScreen({required this.room, Key? key}) : super(key: key);
//
//   RoomResults room;
//   final _controller = Get.find<DeviceController>();
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     return Scaffold(
//       backgroundColor: CustomColors.backgroundColor,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.toNamed(PagesRoutes.createDevice);
//         },
//         backgroundColor: CustomColors.foregroundColor,
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//       floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//
//       body: SafeArea(
//         child: Obx(() {
//               return _controller.isDeviceLoading.value
//                   ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//                   : Padding(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 child: Center(
//                   child: _controller.deviceList.isEmpty
//                       ? Lottie.asset(Images.empty,
//                       width: MediaQuery.sizeOf(context).width / 2)
//                       : CustomScrollView(
//                         slivers: [
//                           SliverToBoxAdapter(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                               child: TextButton(onPressed: (){
//                                 _controller.filterDevicesBasedOnOneTime();
//                                 Get.to(OneTimeDeviceScreen());
//                               }, child: Row(
//                                 children: [
//                                   Icon(Icons.grid_view_outlined, color: CustomColors.foregroundColor,),
//                                   const SizedBox(width: 8,),
//                                   const Text('مشاهده کلید ها', style: TextStyle(fontSize: 16),)
//                                 ],
//                               )),
//                             )),
//
//                           SliverGrid.builder(
//                               gridDelegate:
//                   SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: width > 600 ? 2 : 1,
//                     mainAxisSpacing: 0,
//                     crossAxisSpacing: 12,
//                   ),
//                               itemBuilder: (BuildContext context, int index) {
//                     if (_controller.deviceList[index].deviceType ==
//                           '0') {
//                         return RelayOneTimeWidget(
//                           boardId: _controller.deviceList[index].nodeProject?.boardProject,
//                           nodeId: _controller.deviceList[index].nodeProject?.uniqueId,
//                           title: _controller
//                               .deviceList.value[index].name,
//                           onLongPress: () {
//                             questionDialog(
//                                 title: 'حذف تجهیز',
//                                 question:
//                                 'آیا میخواهید این تجهز را حذف کنید؟',
//                                 onYesClicked: () {
//                                   _controller.deleteDevice(_controller.deviceList[index].id!).then((value) {
//                                     if(value is DataSuccess){
//                                       Get.back();
//                                       const CustomSnackBar.success(message: 'تجهیز با موفقیت حذف شد!');
//                                     }else{
//                                       const CustomSnackBar.error(message: 'خطا در ارسال اطلاعات');
//                                     }
//                                   });
//                                 });
//                           },
//                         );
//                     } else {
//                         return SensorWidget(
//                           title: _controller.deviceList[index].name,
//                           type: _controller
//                               .deviceList[index].deviceType
//                               .toString(),
//                           onLongPress: (){
//                             questionDialog(
//                                 title: 'حذف تجهیز',
//                                 question:
//                                 'آیا میخواهید این تجهز را حذف کنید؟',
//                                 onYesClicked: () {
//                                   _controller.deleteDevice(_controller.deviceList[index].id!).then((value) {
//                                     if(value is DataSuccess){
//                                       Get.back();
//                                       const CustomSnackBar.success(message: 'تجهیز با موفقیت حذف شد!');
//                                     }else{
//                                       const CustomSnackBar.error(message: 'خطا در ارسال اطلاعات');
//                                     }
//                                   });
//                                 });
//                           },
//                         );
//                     }
//
//
//                   },
//                         itemCount: _controller.deviceList.length),]
//                       ),
//                 ),
//               );
//             })
//         ),
//       );
//   }
// }
