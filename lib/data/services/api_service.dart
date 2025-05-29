import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;
import 'package:compe_client/data/services/storage_service.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  StorageService get _storageService => Get.find();
  final String _baseUrl =
      'https://backend-compe-363721261053.us-central1.run.app';

  bool _isRefresh = false;
  Completer<bool>? _refreshCompleter;

  Future<http.Response> _handleRequest(
    Future<http.Response> Function() requestFunction,
  ) async {
    http.Response res = await requestFunction();

    if (res.statusCode == 401) {
      // Handle Access Token Expired
      if (!_isRefresh) {
        _isRefresh = true;
        _refreshCompleter = Completer();

        try {
          bool refreshed = await _refreshToken();
          _isRefresh = false;
          _refreshCompleter!.complete(refreshed);

          if (refreshed) {
            res = await requestFunction();
          } else {
            developer.log('Gagal Refresh Token. Logout!');
          }
        } catch (e) {
          developer.log('Gagal Error Refresh Token ${e.toString()}. Logout!');
          _isRefresh = false;
          _refreshCompleter!.complete(false);
        }
      }
    } else {
      developer.log('Service sedang berlangsung. Menunggu ...');
      bool refreshed = await _refreshCompleter!.future;
      if (refreshed) {
        res = await requestFunction();
      } else {
        developer.log('Service gagal.');
      }
    }
    return res;
  }

  Future<bool> _refreshToken() async {
    final refreshToken = await _storageService.getRefreshToken();
    if (refreshToken.isEmpty) return false;

    try {
      final res = await http.post(
        Uri.parse('$_baseUrl/auth/token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        await _storageService.saveTokens(
          accessToken: data['accessToken'],
          refreshToken: refreshToken,
        );
        return true;
      } else {
        return false;
      }
    } catch (e) {
      developer.log('gagal melakukan refresh token: ${e.toString()}');
      return false;
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await _storageService.getAccessToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> login({
    required String data,
    required String password,
  }) async {
    return await http.post(
      Uri.parse('$_baseUrl/auth/login/user'),
      headers: await _getHeaders(),
      body: jsonEncode(
        {
          'data': data,
          'password': password,
        },
      ),
    );
  }

  Future<http.Response> register({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
  }) async {
    return await http.post(
      Uri.parse('$_baseUrl/auth/register/user'),
      headers: await _getHeaders(),
      body: jsonEncode(
        {
          'userName': userName,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
          'phoneNumber': phoneNumber,
        },
      ),
    );
  }

  Future<http.Response> logout() async {
    final res = _handleRequest(
      () async => http.post(
        Uri.parse('$_baseUrl/auth/logout'),
        headers: await _getHeaders(),
        body: (
          {
            'refreshToken': _storageService.getRefreshToken(),
          },
        ),
      ),
    );
    await _storageService.clearAllData();
    return res;
  }
}
