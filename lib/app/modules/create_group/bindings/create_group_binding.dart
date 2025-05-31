import 'package:compe_client/app/modules/create_group/controllers/create_group_controller.dart';
import 'package:get/get.dart';

class CreateGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CreateGroupController(),
    );
  }
}
