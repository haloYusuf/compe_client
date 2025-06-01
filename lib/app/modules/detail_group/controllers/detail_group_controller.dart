import 'dart:convert';

import 'package:compe_client/app/data/models/all_group_model.dart';
import 'package:compe_client/app/data/models/detail_group_model.dart';
import 'package:compe_client/app/data/services/api_service.dart';
import 'package:compe_client/app/data/services/storage_service.dart';
import 'package:compe_client/core/widgets/confirm_dialog.dart';
import 'package:compe_client/core/widgets/error_dialog.dart';
import 'package:compe_client/core/widgets/loading_dialog.dart';
import 'package:compe_client/core/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DetailGroupController extends GetxController {
  final ApiService _apiService = Get.find();
  final StorageService _storageService = Get.find();
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

  bool getIsAdmin() {
    return (_storageService.getUserInfo()?.id ?? '') ==
        (_detailGroupModel.value?.leader.id ?? '');
  }

  int getGroupStatus() {
    return _detailGroupModel.value?.groupStatus ?? 0;
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

  void handleCopyId(BuildContext context) {
    Clipboard.setData(
      ClipboardData(text: _detailGroupModel.value?.groupId ?? ''),
    ).then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Group id telah disalin ke clipboard!',
            ),
            duration: Duration(
              seconds: 2,
            ),
          ),
        );
      },
    );
  }

  void handleDeleteButton() {
    ConfirmDialog.showConfirmDialog(
      title: 'Konfirmasi',
      message: getIsAdmin()
          ? 'Yakin ingin menghapus group ${_detailGroupModel.value!.groupName} ?'
          : 'Yakin ingin keluar dari group ${_detailGroupModel.value!.groupName} ?',
      onConfirm: () {
        Get.back();
        getIsAdmin() ? handleRemoveGroup() : handleLeaveGroup();
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  void handleLeaveGroup() async {
    LoadingDialog.showLoadingDialog();
    try {
      var res = await _apiService.leaveGroup(
        groupId: _detailGroupModel.value!.groupId,
      );
      var data = jsonDecode(res.body);
      LoadingDialog.hideLoadingDialog();
      if (res.statusCode == 200) {
        SuccessDialog.showSuccessDialog(
          message:
              'Berhasil keluar dari group ${_detailGroupModel.value!.groupName}!',
          onTap: () {
            Get.back();
            Get.back(result: true);
          },
        );
      } else {
        ErrorDialog.showErrorDialog(
          message: '${data['message'] ?? 'Gagal Keluar dari Group!'}',
        );
      }
    } catch (e) {
      ErrorDialog.showErrorDialog(
        message: 'Gagal Keluar dari Group! $e',
      );
    }
  }

  void handleRemoveGroup() async {
    LoadingDialog.showLoadingDialog();
    try {
      var res = await _apiService.removeGroup(
        groupId: _detailGroupModel.value!.groupId,
      );
      var data = jsonDecode(res.body);
      LoadingDialog.hideLoadingDialog();
      if (res.statusCode == 200) {
        SuccessDialog.showSuccessDialog(
          message:
              'Berhasil menghapus group ${_detailGroupModel.value!.groupName}!',
          onTap: () {
            Get.back();
            Get.back(result: true);
          },
        );
      } else {
        ErrorDialog.showErrorDialog(
          message: '${data['message'] ?? 'Gagal Menghapus Group!'}',
        );
      }
    } catch (e) {
      ErrorDialog.showErrorDialog(
        message: 'Gagal Menghapus Group! $e',
      );
    }
  }

  void handleBack() {
    Get.back();
  }
}
