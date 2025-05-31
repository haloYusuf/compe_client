import 'package:compe_client/core/utils/constant.dart';
import 'package:compe_client/app/modules/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    return Scaffold(
      backgroundColor: Color(0xFFCC84E7),
      body: Center(
        child: Obx(
          () => AnimatedOpacity(
            opacity: controller.opacity.value,
            duration: const Duration(seconds: 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Image.asset(
                  '${Constant.assetImage}/splash.png',
                ),
                Text(
                  'Compe App',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: Constant.fontHeading,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Text(
                  'Unlock Your Potential Through Competitions.',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: Constant.fontContent,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
