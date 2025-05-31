import 'dart:convert';
import 'dart:io';

import 'package:compe_client/app/data/models/compe_model.dart';
import 'package:compe_client/app/data/services/api_service.dart';
import 'package:compe_client/core/widgets/error_dialog.dart';
import 'package:compe_client/core/widgets/loading_dialog.dart';
import 'package:compe_client/core/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateGroupController extends GetxController {
  final ApiService _apiService = Get.find();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController maxMemberController = TextEditingController();

  final Rx<File?> _imageFile = Rx<File?>(null);
  File? get imageFile => _imageFile.value;
  final ImagePicker _picker = ImagePicker();
  late CompeModel _init;

  @override
  void onInit() {
    super.onInit();
    _init = Get.arguments['compe'] as CompeModel;
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

  void handleBack() {
    Get.back();
  }

  void handleCreateGroup() async {
    LoadingDialog.showLoadingDialog(
      message: 'Mohon Tunggu...',
    );
    String groupName = groupNameController.text;
    String maxMember = maxMemberController.text;

    if (groupName.isEmpty || maxMember.isEmpty || _imageFile.value == null) {
      Get.snackbar(
        "Gagal",
        "Harap lengkapi data terlebih dahulu!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      try {
        var res = await _apiService.createGroup(
          compeId: _init.compeId,
          groupName: groupName,
          maxMember: maxMember,
          imageFile: _imageFile.value!,
        );
        var data = jsonDecode(res.body);
        LoadingDialog.hideLoadingDialog();
        if (res.statusCode == 201) {
          SuccessDialog.showSuccessDialog(
            message: 'Group berhasil dibuat!',
            onTap: () {
              Get.back();
              Get.back();
            },
          );
        } else {
          ErrorDialog.showErrorDialog(
            message: '${data['message'] ?? 'Gagal membuat group!'}',
          );
        }
      } catch (e) {
        LoadingDialog.hideLoadingDialog();
        ErrorDialog.showErrorDialog(
          message: 'Gagal membuat group! $e',
        );
      }
    }
  }
}
