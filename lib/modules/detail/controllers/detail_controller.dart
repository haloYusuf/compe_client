import 'dart:convert';

import 'package:compe_client/data/models/compe_model.dart';
import 'package:compe_client/data/services/api_service.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final ApiService _apiService = ApiService();
  final _isLoading = false.obs;
  final _isError = false.obs;

  final _compeModel = Rx<CompeModel?>(null);
  late CompeModel _init;

  @override
  void onInit() {
    super.onInit();
    _init = Get.arguments['data'] as CompeModel;
    handleGetData(id: _init.compeId);
  }

  CompeModel getInitData() {
    return _init;
  }

  CompeModel? getCompeData() {
    return _compeModel.value;
  }

  bool getIsLoading() {
    return _isLoading.value;
  }

  bool getIsError() {
    return _isError.value;
  }

  void handleGetData({required String id}) async {
    _isLoading.value = true;
    try {
      var res = await _apiService.getCompeById(id: id);
      if (res.statusCode == 200) {
        _isError.value = false;
        var data = jsonDecode(res.body);
        _compeModel.value = CompeModel.fromJson(data);
      } else if (res.statusCode == 400) {
        _isError.value = true;
      }
    } catch (e) {
      print(e);
      _isError.value = true;
    }
    _isLoading.value = false;
  }

  void handleBack() {
    Get.back();
  }
}
