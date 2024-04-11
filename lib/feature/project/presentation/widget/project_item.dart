import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/styles.dart';

class ProjectItemWidget extends StatelessWidget {
  ProjectItemWidget(
      {required this.title,
      required this.onClick,

      Key? key})
      : super(key: key);

  String title;
  Function() onClick;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return InkWell(
      onTap: onClick,
      child: Container(
        width: width * 0.4,
        height: height / 5,
        decoration: BoxDecoration(
          color: CustomColors.itemColor,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
        ),
        child: Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(AppDimensions.smallPadding),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.backgroundLogo),
                fit: BoxFit.cover,
                opacity: 0.11),
          ),
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border.all(width: 2, color: CustomColors.foregroundColor),
                borderRadius:
                    BorderRadius.circular(AppDimensions.borderRadius)),
            child: Center(
              child: Text(
                title,
                style: AppStyles.style13,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
