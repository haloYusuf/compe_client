import 'dart:convert';

import 'package:compe_client/app/data/models/all_group_model.dart';
import 'package:compe_client/app/data/services/api_service.dart';
import 'package:compe_client/app/data/services/storage_service.dart';
import 'package:compe_client/app/route/route_name.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GroupController extends GetxController {
  final ApiService _apiService = Get.find();
  final StorageService _storageService = Get.find();
  final TextEditingController searchController = TextEditingController();

  final _isLoading = false.obs;
  final _isError = false.obs;
  final _searchValue = ''.obs;

  final _allGroupModel = Rx<List<AllGroupModel>>([]);
  final _filteredModel = Rx<List<AllGroupModel>>([]);

  // @override
  // void onReady() {
  //   super.onReady();
  //   getAllUserGroup();
  // }

  @override
  void onInit() {
    super.onInit();
    getAllUserGroup();
  }

  List<AllGroupModel> getAllGroup() {
    return _filteredModel.value;
  }

  String getUserId() {
    return _storageService.getUserInfo()?.id ?? '';
  }

  bool getIsLoading() {
    return _isLoading.value;
  }

  bool getIsError() {
    return _isError.value;
  }

  void setSearchValue(String v) {
    _searchValue.value = v;
    _filteredModel.value = _allGroupModel.value
        .where(
          (element) => element.groupModel.groupName.toLowerCase().contains(
                _searchValue.value.toLowerCase(),
              ),
        )
        .toList();
  }

  void getAllUserGroup() async {
    _isLoading.value = true;
    try {
      var res = await _apiService.getAllGroupById();
      if (res.statusCode == 200) {
        _isError.value = false;
        var data = jsonDecode(res.body);
        _allGroupModel.value = List<AllGroupModel>.from(
          data['data'].map(
            (v) => AllGroupModel.fromJson(v),
          ),
        );
        _filteredModel.value = _allGroupModel.value;
      } else {
        _isError.value = true;
      }
    } catch (e) {
      print(e);
      _isError.value = true;
    }
    _isLoading.value = false;
  }

  void handleItemTap(int index) async {
    var result = await Get.toNamed(RouteName.detailGroup, arguments: {
      'group': _filteredModel.value[index],
    });

    if (result != null && result == true) {
      getAllUserGroup();
    }
  }

  void handleEditTap(int index) async {
    var result = await Get.toNamed(RouteName.editGroup, arguments: {
      'group': _filteredModel.value[index].groupModel,
    });

    if (result != null && result == true) {
      getAllUserGroup();
    }
  }
}
