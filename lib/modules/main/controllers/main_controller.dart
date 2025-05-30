import 'package:compe_client/data/models/user_model.dart';
import 'package:compe_client/data/services/storage_service.dart';
import 'package:compe_client/modules/auth/controllers/auth_controller.dart';
import 'package:compe_client/modules/group/views/group_view.dart';
import 'package:compe_client/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final AuthController _authController = AuthController();
  final StorageService _storageService = StorageService();

  final _currentIndex = 0.obs;
  final _listAllView = [
    HomeView(),
    GroupView(),
  ];

  @override
  void onReady() {
    super.onReady();
    getCurrentUser();
  }

  UserModel? getCurrentUser() {
    return _storageService.getUserInfo();
  }

  void setCurrentIndex(int index) {
    if (index == 2) {
      handleLogout();
    } else {
      _currentIndex.value = index;
    }
  }

  int getCurrentIndex() {
    return _currentIndex.value;
  }

  List<Widget> getAllView() {
    return _listAllView;
  }

  void handleLogout() async {
    await _authController.logout();
  }
}
