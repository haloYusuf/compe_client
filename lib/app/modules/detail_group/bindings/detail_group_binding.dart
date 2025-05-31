import 'package:compe_client/app/modules/detail_group/controllers/detail_group_controller.dart';
import 'package:get/get.dart';

class DetailGroupBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DetailGroupController(),);
  }
}