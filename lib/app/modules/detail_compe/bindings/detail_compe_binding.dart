import 'package:compe_client/app/modules/detail_compe/controllers/detail_compe_controller.dart';
import 'package:get/get.dart';

class DetailCompeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => DetailCompeController(),
    );
  }
}
