import 'package:compe_client/app/data/services/api_service.dart';
import 'package:compe_client/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}
