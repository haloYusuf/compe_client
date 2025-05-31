import 'package:compe_client/app/modules/all_compe/controllers/all_compe_controller.dart';
import 'package:get/get.dart';

class AllCompeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AllCompeController(),
    );
  }
}
