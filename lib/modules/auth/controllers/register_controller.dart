import 'dart:convert';

import 'package:compe_client/data/services/api_service.dart';
import 'package:compe_client/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final ApiService _apiService = ApiService();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final _isVisiblePass = false.obs;
  final _isVisibleConfirmPass = false.obs;
  final _isLoading = false.obs;

  bool getVisibilityPass() {
    return _isVisiblePass.value;
  }

  bool getVisibilityConfirmPass() {
    return _isVisibleConfirmPass.value;
  }

  bool getIsLoading() {
    return _isLoading.value;
  }

  void handleSetVisibilityPass() {
    _isVisiblePass.value = !_isVisiblePass.value;
  }

  void handleSetVisibilityConfirmPass() {
    _isVisibleConfirmPass.value = !_isVisibleConfirmPass.value;
  }

  void handleBack() {
    Get.back();
  }

  void handleLoginButton() {
    Get.back();
  }

  void handleRegister() async {
    String userName = userNameController.text;
    String email = emailController.text;
    String pass = passController.text;
    String confirmPass = confirmPassController.text;
    String phoneNumber = phoneNumberController.text;

    _isLoading.value = true;

    if (userName.isEmpty ||
        email.isEmpty ||
        pass.isEmpty ||
        confirmPass.isEmpty ||
        phoneNumber.isEmpty) {
      _isLoading.value = false;
      Get.snackbar(
        'Gagal',
        'Lengkapi data terlebih dahulu!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      _isLoading.value = false;
      final res = await _apiService.register(
        userName: userName,
        email: email,
        password: pass,
        confirmPassword: confirmPass,
        phoneNumber: phoneNumber,
      );

      if (res.statusCode == 201) {
        Get.offAllNamed(RouteName.login);
      } else {
        final data = jsonDecode(res.body);
        Get.snackbar(
          'Gagal',
          '${data['message'] ?? 'Register tidak berhasil!'}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}
