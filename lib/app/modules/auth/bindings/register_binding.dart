import 'package:compe_client/app/modules/auth/controllers/register_controller.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RegisterController(),
    );
  }
}
