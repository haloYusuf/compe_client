import 'dart:convert';

import 'package:compe_client/app/data/models/compe_model.dart';
import 'package:compe_client/app/data/models/user_model.dart';
import 'package:compe_client/app/data/services/api_service.dart';
import 'package:compe_client/app/data/services/storage_service.dart';
import 'package:compe_client/app/route/route_name.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ApiService _apiService = Get.find();
  final StorageService _storageService = Get.find();

  final _userModel = Rx<UserModel?>(null);
  final _isLoading = false.obs;
  final _isError = false.obs;

  final _compeModel = Rx<List<CompeModel>>([]);

  // @override
  // void onReady() {
  //   super.onReady();
  //   _getUserData();
  //   handleGetData();
  // }

  @override
  void onInit() {
    super.onInit();
    _getUserData();
    handleGetData();
  }

  void _getUserData() {
    _userModel.value = _storageService.getUserInfo();
  }

  UserModel? getUserData() {
    return _userModel.value;
  }

  List<CompeModel> getHighlightCompe() {
    return _compeModel.value;
  }

  bool getIsLoading() {
    return _isLoading.value;
  }

  bool getIsError() {
    return _isError.value;
  }

  void handleGetData() async {
    _isLoading.value = true;
    try {
      var res = await _apiService.getHighlightCompe();
      if (res.statusCode == 200) {
        _isError.value = false;
        var data = jsonDecode(res.body);
        _compeModel.value = List<CompeModel>.from(
          data['data'].map(
            (v) => CompeModel.fromJson(v),
          ),
        );
      } else if (res.statusCode == 400) {
        _isError.value = true;
      }
    } catch (e) {
      print(e);
      _isError.value = true;
    }
    _isLoading.value = false;
  }

  void handleSeeAll() {
    Get.toNamed(RouteName.allCompe);
  }

  void handleListTapped(int index) {
    Get.toNamed(
      RouteName.detailCompe,
      arguments: {
        'data': _compeModel.value[index],
      },
    );
  }
}
