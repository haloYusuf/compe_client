import 'package:compe_client/modules/all_compe/bindings/all_compe_binding.dart';
import 'package:compe_client/modules/all_compe/views/all_compe_view.dart';
import 'package:compe_client/modules/auth/bindings/login_binding.dart';
import 'package:compe_client/modules/auth/bindings/register_binding.dart';
import 'package:compe_client/modules/auth/views/login_view.dart';
import 'package:compe_client/modules/auth/views/register_view.dart';
import 'package:compe_client/modules/detail/bindings/detail_binding.dart';
import 'package:compe_client/modules/detail/views/detail_view.dart';
import 'package:compe_client/modules/main/bindings/main_binding.dart';
import 'package:compe_client/modules/main/views/main_view.dart';
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
      name: RouteName.main,
      binding: MainBinding(),
      page: () => MainView(),
    ),
    GetPage(
      name: RouteName.detail,
      binding: DetailBinding(),
      page: () => DetailView(),
    ),
    GetPage(
      name: RouteName.allCompe,
      binding: AllCompeBinding(),
      page: () => AllCompeView(),
    ),
  ];
}
