import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Get.toNamed('/home');
    });
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: Get.height/2,
          width: Get.width/2,
          child: Image.network(
          "https://lh6.ggpht.com/aiY9J8YK8Lzr7hMC7nZWlZGiBn8TF_PY7NVNy5U1i5g4zG8yEPzEZTJK2WwbWJUogg"),
        )
      ),
    );
  }
}