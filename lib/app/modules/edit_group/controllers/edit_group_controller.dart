import 'dart:convert';
import 'dart:io';

import 'package:compe_client/app/data/models/group_model.dart';
import 'package:compe_client/app/data/services/api_service.dart';
import 'package:compe_client/core/widgets/error_dialog.dart';
import 'package:compe_client/core/widgets/loading_dialog.dart';
import 'package:compe_client/core/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditGroupController extends GetxController {
  final ApiService _apiService = Get.find();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController maxMemberController = TextEditingController();

  final Rx<File?> _imageFile = Rx<File?>(null);
  File? get imageFile => _imageFile.value;
  final ImagePicker _picker = ImagePicker();
  late GroupModel _init;

  @override
  void onInit() {
    super.onInit();
    _init = Get.arguments['group'] as GroupModel;
    groupNameController.text = _init.groupName;
    maxMemberController.text = _init.maxMember.toString();
  }

  String getInitImage() {
    return _init.groupImg;
  }

  Future<void> pickImage({
    required ImageSource source,
  }) async {
    PermissionStatus status;
    String permissionTypeForDialog = "";

    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
      permissionTypeForDialog = 'kamera';
    } else {
      status = await Permission.photos.request();
      permissionTypeForDialog = "Galeri Foto";
    }

    if (status.isGranted) {
      try {
        final XFile? pickedFile =
            await _picker.pickImage(source: source, imageQuality: 70);
        if (pickedFile != null) {
          _imageFile.value = File(pickedFile.path);
        }
      } catch (e) {
        Get.snackbar(
          "Error Saat Memilih Gambar",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } else if (status.isDenied) {
      Get.snackbar(
        "Izin Ditolak",
        "Izin untuk mengakses $permissionTypeForDialog ditolak. Anda tidak dapat memilih gambar.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } else if (status.isPermanentlyDenied) {
      Get.snackbar(
        "Izin Ditolak Permanen",
        "Izin untuk mengakses $permissionTypeForDialog ditolak secara permanen. Silakan buka pengaturan aplikasi untuk memberikan izin.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        mainButton: TextButton(
          onPressed: () {
            openAppSettings();
          },
          child: Text(
            "Buka Pengaturan",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        duration: Duration(seconds: 5),
      );
    }
  }

  void handleEditGroup() async {
    LoadingDialog.showLoadingDialog(
      message: 'Mohon Tunggu...',
    );
    String groupName = groupNameController.text;
    String maxMember = maxMemberController.text;

    if (groupName.isEmpty || maxMember.isEmpty) {
      Get.snackbar(
        "Gagal",
        "Harap lengkapi data terlebih dahulu!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      try {
        var res = await _apiService.editGroup(
          groupId: _init.groupId,
          groupName: groupName,
          maxMember: maxMember,
          imageFile: _imageFile.value,
        );
        var data = jsonDecode(res.body);
        LoadingDialog.hideLoadingDialog();
        if (res.statusCode == 200) {
          SuccessDialog.showSuccessDialog(
            message: 'Group berhasil diubah!',
            onTap: () {
              Get.back();
              Get.back(
                result: true,
              );
            },
          );
        } else {
          ErrorDialog.showErrorDialog(
            message: '${data['message'] ?? 'Gagal mengubah group!'}',
          );
        }
      } catch (e) {
        LoadingDialog.hideLoadingDialog();
        ErrorDialog.showErrorDialog(
          message: 'Gagal mengubah group! $e',
        );
      }
    }
  }

  void handleBack() {
    Get.back();
  }
}
