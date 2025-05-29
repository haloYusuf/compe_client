import 'package:compe_client/bindings/initial_binding.dart';
import 'package:compe_client/route/route_name.dart';
import 'package:compe_client/route/route_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
