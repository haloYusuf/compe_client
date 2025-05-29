import 'package:compe_client/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<HomeController>();
    return Scaffold(
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
