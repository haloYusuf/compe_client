import 'package:compe_client/bindings/initial_binding.dart';
import 'package:compe_client/data/services/storage_service.dart';
import 'package:compe_client/route/route_name.dart';
import 'package:compe_client/route/route_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = StorageService();
  await storageService.init();
  Get.put<StorageService>(storageService, permanent: true);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Compe App',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.splash,
      getPages: RoutePage.pages,
      initialBinding: InitialBinding(),
    );
  }
}
