import 'package:compe_client/modules/splash/splash_binding.dart';
import 'package:compe_client/modules/splash/splash_view.dart';
import 'package:compe_client/route/route_name.dart';
import 'package:get/get.dart';

class RoutePage {
  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: RouteName.splash,
      binding: SplashBinding(),
      page: () => SplashView(),
    ),
  ];
}
