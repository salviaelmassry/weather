import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/resources/app_color.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? const CircularProgressIndicator(
            strokeWidth: 5,
            color: AppColors.chambray,
          )
        : const CupertinoActivityIndicator(
            radius: 5,
            color: AppColors.chambray,
          );
  }
}
