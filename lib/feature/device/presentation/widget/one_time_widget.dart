import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/utils.dart';
import '../../../../core/resource/mqtt_service.dart';

class OneTimeWidget extends StatelessWidget {
  OneTimeWidget(
      {required this.title, required this.boardUniqueId, required this.nodeId, Key? key})
      : super(key: key);

  final _controller = Get.find<MqttService>();
  var isOneTimeButtonEnabled = false.obs;
  String? title;
  int? boardUniqueId;
  int? nodeId;

  late String projectName;
  late String username;

  setRelayOneTimeValue() {
    for (var element in _controller.relayDataList) {
      if (element.boardId == boardUniqueId) {
        switch (nodeId) {
          case 1:
            isOneTimeButtonEnabled.value = element.key1 ?? false;
          case 2:
            isOneTimeButtonEnabled.value = element.key2 ?? false;
          case 3:
            isOneTimeButtonEnabled.value = element.key3 ?? false;
          case 4:
            isOneTimeButtonEnabled.value = element.key4 ?? false;
          case 5:
            isOneTimeButtonEnabled.value = element.key5 ?? false;
          case 6:
            isOneTimeButtonEnabled.value = element.key6 ?? false;
          case 7:
            isOneTimeButtonEnabled.value = element.key7 ?? false;
          case 8:
            isOneTimeButtonEnabled.value = element.key8 ?? false;
          case 9:
            isOneTimeButtonEnabled.value = element.key9 ?? false;
          case 10:
            isOneTimeButtonEnabled.value = element.key10 ?? false;
          case 11:
            isOneTimeButtonEnabled.value = element.key11 ?? false;
          case 12:
            isOneTimeButtonEnabled.value = element.key12 ?? false;
        }
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.itemColor,
          image: const DecorationImage(
              image: AssetImage((Images.backgroundLogo)),
              fit: BoxFit.cover,
              opacity: 0.05),
          borderRadius: BorderRadius.circular(
              AppDimensions.borderRadius),
          border: Border.all(
              color: CustomColors.foregroundColor,
              width: 1),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8),
              child: Text(
                title ??
                    '',
                style:
                 const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Expanded(
              child: GetBuilder<MqttService>(builder: (logic) {
                setRelayOneTimeValue();
                return IconButton(
                  onPressed: () {
                    logic.update();
                    projectName = GetStorage().read(
                        AppUtils.projectNameConst);
                    username = GetStorage().read(
                        AppUtils.username);

                    if (!isOneTimeButtonEnabled.value) {
                      ///////////// _controller را به logic تغییر دادم:
                      logic.publishMessage(
                          {
                            'type':'relay',
                            'board_id': boardUniqueId,
                            'node_id': nodeId,
                            'node_status': true
                          },
                          '$projectName/$username/relay');
                    } else {
                      logic.publishMessage(
                          {
                            'type':'relay',
                            'board_id': boardUniqueId,
                            'node_id': nodeId,
                            'node_status': true
                          },
                          '$projectName/$username/relay');
                    }
                  },
                  icon: Icon(
                      Icons
                          .power_settings_new_rounded,
                      color: isOneTimeButtonEnabled
                          .value ? Colors.green : CustomColors
                          .foregroundColor,
                      size: Get.width / 14),
                );
              }),
            ),
          ],
        ),
      ),
    );

  }
}
