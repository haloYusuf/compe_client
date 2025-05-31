import 'dart:convert';

import 'package:compe_client/app/data/models/compe_model.dart';
import 'package:compe_client/app/data/services/api_service.dart';
import 'package:compe_client/app/route/route_name.dart';
import 'package:get/get.dart';

class AllCompeController extends GetxController {
  final ApiService _apiService = Get.find();

  final _isLoading = false.obs;
  final _isError = false.obs;
  final _searchValue = ''.obs;

  final _compeModel = Rx<List<CompeModel>>([]);
  final _filteredModel = Rx<List<CompeModel>>([]);

  @override
  void onReady() {
    super.onReady();
    handleGetData();
  }

  List<CompeModel> getAllCompe() {
    return _filteredModel.value;
  }

  bool getIsLoading() {
    return _isLoading.value;
  }

  bool getIsError() {
    return _isError.value;
  }

  void setSearchValue(String v) {
    _searchValue.value = v;
    _filteredModel.value = _compeModel.value
        .where(
          (element) => element.compeName.toLowerCase().contains(
                _searchValue.value.toLowerCase(),
              ),
        )
        .toList();
  }

  void handleGetData() async {
    _isLoading.value = true;
    try {
      var res = await _apiService.getAllCompe();
      if (res.statusCode == 200) {
        _isError.value = false;
        var data = jsonDecode(res.body);
        _compeModel.value = List<CompeModel>.from(
          data['data'].map(
            (v) => CompeModel.fromJson(v),
          ),
        );
        _filteredModel.value = _compeModel.value;
      } else if (res.statusCode == 400) {
        _isError.value = true;
      }
    } catch (e) {
      print(e);
      _isError.value = true;
    }
    _isLoading.value = false;
  }

  void handleListTapped(int index) {
    Get.toNamed(
      RouteName.detailCompe,
      arguments: {
        'data': _filteredModel.value[index],
      },
    );
  }

  void handleBack() {
    Get.back();
  }
}
