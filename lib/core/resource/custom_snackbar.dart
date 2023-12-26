import 'package:flutter/material.dart';
import 'package:get/get.dart';

customSuccessSnackBar(String title){
  return Get.snackbar(title, '', backgroundColor: Colors.green);
}

customErrorSnackBar(String title){
  return Get.snackbar(title, '', backgroundColor: Colors.green,);
}