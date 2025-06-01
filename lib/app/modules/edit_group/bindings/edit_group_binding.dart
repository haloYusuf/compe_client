import 'package:compe_client/app/modules/edit_group/controllers/edit_group_controller.dart';
import 'package:get/get.dart';

class EditGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => EditGroupController(),
    );
  }
}
