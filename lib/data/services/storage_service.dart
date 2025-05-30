import 'dart:core';

import 'package:compe_client/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  final _storage = const FlutterSecureStorage();
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'Token';

  final _userBox = GetStorage('UserDataBox');
  static const _userInfoKey = 'userInfo';

  Future<StorageService> init() async {
    await GetStorage.init('UserDataBox');
    return this;
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey) ?? '';
  }

  Future<String> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey) ?? '';
  }

  Future<void> clearAllToken() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  Future<void> saveUserInfo(UserModel user) async {
    await _userBox.write(
      _userInfoKey,
      user.toJson(),
    );
  }

  UserModel? getUserInfo() {
    final Map<String, dynamic>? userData = _userBox.read<Map<String, dynamic>>(
      _userInfoKey,
    );
    if (userData != null) {
      return UserModel.fromJson(userData);
    }

    return null;
  }

  Future<void> clearUserInfo() async {
    await _userBox.remove(_userInfoKey);
  }

  Future<void> clearAllData() async {
    await clearAllToken();
    await clearUserInfo();
  }
}
