import 'package:compe_client/app/modules/main/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.getAllView()[controller.getCurrentIndex()],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.getCurrentIndex(),
          onTap: controller.setCurrentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_rounded),
              label: 'My Group',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout_rounded),
              label: 'Log Out',
            ),
          ],
        ),
      ),
    );
  }
}
