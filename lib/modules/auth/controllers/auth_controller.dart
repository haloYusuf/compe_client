import 'dart:convert';

import 'package:compe_client/data/models/user_model.dart';
import 'package:compe_client/data/services/api_service.dart';
import 'package:compe_client/data/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthController extends GetxController {
  ApiService get _apiService => Get.find();
  StorageService get _storageService => Get.find();

  var isLogin = false.obs;
  var isLoading = false.obs;

  var currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final token = await _storageService.getAccessToken();
    isLoading.value = true;
    isLogin.value = token.isNotEmpty;

    if (isLogin.value) {
      if (!JwtDecoder.isExpired(token)) {
        await _processTokenAndSaveUserInfo(token);
      } else {
        final storedUser = _storageService.getUserInfo();
        if (storedUser != null) {
          currentUser.value = storedUser;
        }
      }
    } else {
      final storedUser = _storageService.getUserInfo();
      if (storedUser != null) {
        currentUser.value = storedUser;
      }
    }

    isLoading.value = false;
  }

  Future<void> _processTokenAndSaveUserInfo(String token) async {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final user = UserModel.fromJson(decodedToken);
      currentUser.value = user;
      await _storageService.saveUserInfo(user);
      isLogin.value = true;
    } catch (e) {
      await logout();
    }
  }

  Future<bool> login(String data, String password) async {
    isLoading.value = true;
    try {
      final response = await _apiService.login(data: data, password: password);
      isLoading.value = false;

      if (response.statusCode == 200) {
        final newAccessToken = await _storageService.getAccessToken();
        if (newAccessToken.isNotEmpty) {
          await _processTokenAndSaveUserInfo(newAccessToken);
        } else {
          Get.snackbar(
              'Login Gagal', 'Gagal mendapatkan access token setelah login.');
          return false;
        }
        // Get.offAllNamed(AppRoutes.HOME);
        return true;
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar('Login Gagal',
            errorData['message'] ?? 'Email atau Password salah.');
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
      return false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await _apiService.logout();
    } catch (e) {
      await _storageService.clearAllData();
    } finally {
      currentUser.value = null;
      isLogin.value = false;
      isLoading.value = false;
      // Get.offAllNamed(AppRoutes.LOGIN);
    }
  }

  Future<void> updateUserInfoFromNewToken() async {
    final token = await _storageService.getAccessToken();
    if (token.isNotEmpty && !JwtDecoder.isExpired(token)) {
      await _processTokenAndSaveUserInfo(token);
    }
  }
}
