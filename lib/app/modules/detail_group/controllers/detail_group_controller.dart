import 'dart:convert';

import 'package:compe_client/app/data/models/all_group_model.dart';
import 'package:compe_client/app/data/models/detail_group_model.dart';
import 'package:compe_client/app/data/services/api_service.dart';
import 'package:get/get.dart';

class DetailGroupController extends GetxController {
  final ApiService _apiService = Get.find();
  final _isLoading = false.obs;
  final _isError = false.obs;

  final _detailGroupModel = Rx<DetailGroupModel?>(null);
  late AllGroupModel _init;

  @override
  void onInit() {
    super.onInit();
    _init = Get.arguments['group'] as AllGroupModel;
    handleGetData(groupId: _init.groupModel.groupId);
  }

  AllGroupModel getInitData() {
    return _init;
  }

  DetailGroupModel? getDetailGroupData() {
    return _detailGroupModel.value;
  }

  bool getIsLoading() {
    return _isLoading.value;
  }

  bool getIsError() {
    return _isError.value;
  }

  void handleGetData({required String groupId}) async {
    _isLoading.value = true;
    try {
      var res = await _apiService.getDetailGroup(
        groupId: groupId,
      );
      if (res.statusCode == 200) {
        _isError.value = false;
        var data = jsonDecode(res.body);
        _detailGroupModel.value = DetailGroupModel.fromJson(data);
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
