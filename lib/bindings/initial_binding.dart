import 'package:compe_client/data/services/api_service.dart';
import 'package:compe_client/data/services/storage_service.dart';
import 'package:compe_client/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<StorageService>(
      () async {
        final storage = StorageService();
        await storage.init();
        return storage;
      },
      permanent: true,
    );
    Get.put(ApiService(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }
}
