import 'dart:convert';

import 'package:compe_client/core/widgets/error_dialog.dart';
import 'package:compe_client/core/widgets/form_dialog.dart';
import 'package:compe_client/core/widgets/loading_dialog.dart';
import 'package:compe_client/app/data/models/compe_model.dart';
import 'package:compe_client/app/data/services/api_service.dart';
import 'package:compe_client/app/route/route_name.dart';
import 'package:compe_client/core/widgets/success_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DetailCompeController extends GetxController {
  final ApiService _apiService = Get.find();
  final _isLoading = false.obs;
  final _isError = false.obs;

  final _compeModel = Rx<CompeModel?>(null);
  late CompeModel _init;

  TextEditingController _groupIdController = TextEditingController();

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

  void handleCreateGroup() async {
    LoadingDialog.showLoadingDialog(
      message: 'Memproses data ...',
    );
    try {
      var res = await _apiService.checkUserInCompe(
        compeId: _compeModel.value!.compeId,
      );
      var data = jsonDecode(res.body);
      LoadingDialog.hideLoadingDialog();
      if (res.statusCode == 200) {
        bool isMember = bool.tryParse(data['isMember'].toString()) ?? true;
        if (isMember) {
          ErrorDialog.showErrorDialog(
            message: 'User sudah memiliki kelompok di Kompetisi ini!',
          );
        } else {
          Get.toNamed(
            RouteName.createGroup,
            arguments: {
              'compe': _compeModel.value,
            },
          );
        }
      } else {
        ErrorDialog.showErrorDialog(
          message: data['message'] ?? 'Gagal memproses data!',
        );
      }
    } catch (e) {
      LoadingDialog.hideLoadingDialog();
      ErrorDialog.showErrorDialog(
        message: 'Gagal memproses data! $e',
      );
      print(e);
    }
  }

  void handleJoinGroup() async {
    LoadingDialog.showLoadingDialog(
      message: 'Memproses data ...',
    );

    try {
      var res1 = await _apiService.checkUserInCompe(
        compeId: _compeModel.value!.compeId,
      );

      var data = jsonDecode(res1.body);
      LoadingDialog.hideLoadingDialog();
      if (res1.statusCode == 200) {
        bool isMember = bool.tryParse(data['isMember'].toString()) ?? true;
        if (isMember) {
          ErrorDialog.showErrorDialog(
            message: 'User sudah memiliki kelompok di Kompetisi ini!',
          );
        } else {
          _groupIdController = TextEditingController();
          FormDialog.showGroupIdInputDialog(
            title: 'Masukkan ID Group',
            hintText: 'ID Group',
            cancelButtonText: 'Batal',
            confirmButtonText: 'Masuk',
            controller: _groupIdController,
            onNext: () async {
              LoadingDialog.showLoadingDialog(
                message: 'Memasukkan Data ...',
              );
              var res2 = await _apiService.joinGroup(
                groupId: _groupIdController.text,
              );
              data = jsonDecode(res2.body);
              LoadingDialog.hideLoadingDialog();
              if (res2.statusCode == 201) {
                SuccessDialog.showSuccessDialog(
                  message: 'Anda berhasil bergabung kedalam group!',
                  onTap: () {
                    Get.back();
                  },
                );
              } else {
                ErrorDialog.showErrorDialog(
                  message:
                      '${data['message'] ?? 'Anda gagal bergabung kedalam group!'}',
                );
              }
              _groupIdController.dispose();
            },
          );
        }
      } else {
        ErrorDialog.showErrorDialog(
          message: data['message'] ?? 'Gagal memproses data!',
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void handleBack() {
    Get.back();
  }
}
