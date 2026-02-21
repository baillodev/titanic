import 'package:dio/dio.dart';
import 'package:titanic_app/models/prediction.dart';
import 'package:titanic_app/models/titanic.dart';
import 'package:titanic_app/services/auth_service.dart';
import 'package:titanic_app/utils/constants.dart';

class ApiService {
  final Dio _dio;
  final AuthService _authService;

  ApiService(this._dio, this._authService) {
    _dio.interceptors.add(_AuthInterceptor(_authService));
  }

  Future<Prediction> prediction(
    Titanic data, {
    required String modelName,
  }) async {
    try {
      final response = await _dio.post(
        apiPredict,
        data: data.toJson(),
        queryParameters: {
          "model": modelName,
        },
      );

      return Prediction.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data['details'] ?? "Erreur lors de la prédection";
    }
  }
}

class _AuthInterceptor extends Interceptor {
  final AuthService _authService;

  _AuthInterceptor(this._authService);

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final isPublicRoute =
        options.path == authLogin || options.path == authRegister;

    if (isPublicRoute) {
      return super.onRequest(options, handler);
    }

    final token = await _authService.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}
