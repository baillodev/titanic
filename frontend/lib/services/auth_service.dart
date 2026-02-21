import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:titanic_app/models/user_models.dart';
import 'package:titanic_app/utils/constants.dart';

class AuthService {
  final _storage = FlutterSecureStorage();

  late final Dio _dio;

  AuthService(this._dio);

  Future<void> saveToken(String token) async {
    await _storage.write(key: authTokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: authTokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: authTokenKey);
  }

  Future<BaseUser> fetchMe () async {
    try {
      final response = await _dio.get(authMe);
      return BaseUser.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data['detail'] ?? "Erreur lors de la récupération des informations de l'utilisateur";
    }
  }

  Future<AuthenticatedUser> register(UserCredentials user) async {
    try {

      final response = await _dio.post(authRegister, data: user.toJson());

      final token = response.data['access_token'] as String;

      await saveToken(token);

      return AuthenticatedUser.fromJson(response.data);

    } on DioException catch (e) {
      throw e.response?.data['detail'] ?? "Erreur d'inscription";
    }
  }

  Future<AuthenticatedUser> login(UserCredentials user) async {
    try {
      final response = await _dio.post(authLogin, data: user.toJson());

      final token = response.data['access_token'] as String;

      await saveToken(token);

      return AuthenticatedUser.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data['detail'] ?? "Erreur de connexion";
    }
  }

  Future<void> logout() async {
    await deleteToken();
  }
}