import 'dart:async';

import 'package:compe_client/modules/auth/controllers/auth_controller.dart';
import 'package:compe_client/route/route_name.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final AuthController authController = Get.find();
  var opacity = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    _showSplash();
  }

  void _showSplash() {
    Timer(
      const Duration(seconds: 1),
      () {
        opacity.value = 1.0;
      },
    );

    Timer(
      const Duration(seconds: 2),
      () {
        if (authController.isLogin.value) {
          Get.offAllNamed(RouteName.main);
        } else {
          Get.offAllNamed(RouteName.login);
        }
      },
    );
  }
}
