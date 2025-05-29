import 'package:compe_client/modules/auth/bindings/login_binding.dart';
import 'package:compe_client/modules/auth/bindings/register_binding.dart';
import 'package:compe_client/modules/auth/views/login_view.dart';
import 'package:compe_client/modules/auth/views/register_view.dart';
import 'package:compe_client/modules/home/bindings/home_binding.dart';
import 'package:compe_client/modules/home/views/home_view.dart';
import 'package:compe_client/modules/splash/bindings/splash_binding.dart';
import 'package:compe_client/modules/splash/views/splash_view.dart';
import 'package:compe_client/route/route_name.dart';
import 'package:get/get.dart';

class RoutePage {
  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: RouteName.splash,
      binding: SplashBinding(),
      page: () => SplashView(),
    ),
    GetPage(
      name: RouteName.login,
      binding: LoginBinding(),
      page: () => LoginView(),
    ),
    GetPage(
      name: RouteName.register,
      binding: RegisterBinding(),
      page: () => RegisterView(),
    ),
    GetPage(
      name: RouteName.home,
      binding: HomeBinding(),
      page: () => HomeView(),
    ),
  ];
}
