import 'package:compe_client/app/modules/main/controllers/main_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MainController(),
    );
  }
}
