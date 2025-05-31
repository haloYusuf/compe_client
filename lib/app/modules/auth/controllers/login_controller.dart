import 'package:compe_client/app/modules/auth/controllers/auth_controller.dart';
import 'package:compe_client/app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthController authController = Get.find();

  TextEditingController dataController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _isVisible = true.obs;
  final _isLoading = false.obs;

  bool getVisibilityPass() {
    return _isVisible.value;
  }

  bool getIsLoading() {
    return _isLoading.value;
  }

  void handleVisiblePass() {
    _isVisible.value = !_isVisible.value;
  }

  void handleRegisterButton() {
    Get.toNamed(RouteName.register);
  }

  void handleLogin() async {
    String data = dataController.text;
    String pass = passController.text;

    _isLoading.value = true;
    if (data.isEmpty || pass.isEmpty) {
      Get.snackbar(
        'Gagal',
        'Lengkapi data terlebih dahulu!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      bool value = await authController.login(data, pass);
      if (value) {
        Get.offAllNamed(RouteName.main);
      }
    }
    _isLoading.value = false;
  }
}
