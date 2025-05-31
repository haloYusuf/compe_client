import 'package:compe_client/app/modules/all_compe/bindings/all_compe_binding.dart';
import 'package:compe_client/app/modules/all_compe/views/all_compe_view.dart';
import 'package:compe_client/app/modules/auth/bindings/login_binding.dart';
import 'package:compe_client/app/modules/auth/bindings/register_binding.dart';
import 'package:compe_client/app/modules/auth/views/login_view.dart';
import 'package:compe_client/app/modules/auth/views/register_view.dart';
import 'package:compe_client/app/modules/create_group/bindings/create_group_binding.dart';
import 'package:compe_client/app/modules/create_group/views/create_group_view.dart';
import 'package:compe_client/app/modules/detail_compe/bindings/detail_compe_binding.dart';
import 'package:compe_client/app/modules/detail_compe/views/detail_compe_view.dart';
import 'package:compe_client/app/modules/detail_group/bindings/detail_group_binding.dart';
import 'package:compe_client/app/modules/detail_group/views/detail_group_view.dart';
import 'package:compe_client/app/modules/main/bindings/main_binding.dart';
import 'package:compe_client/app/modules/main/views/main_view.dart';
import 'package:compe_client/app/modules/splash/bindings/splash_binding.dart';
import 'package:compe_client/app/modules/splash/views/splash_view.dart';
import 'package:compe_client/app/route/route_name.dart';
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
      name: RouteName.allCompe,
      binding: AllCompeBinding(),
      page: () => AllCompeView(),
    ),
    GetPage(
      name: RouteName.detailCompe,
      binding: DetailCompeBinding(),
      page: () => DetailCompeView(),
    ),
    GetPage(
      name: RouteName.createGroup,
      binding: CreateGroupBinding(),
      page: () => CreateGroupView(),
    ),
    GetPage(
      name: RouteName.detailGroup,
      binding: DetailGroupBinding(),
      page: () => DetailGroupView(),
    ),
  ];
}
