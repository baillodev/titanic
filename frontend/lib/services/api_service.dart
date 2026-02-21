import 'package:dio/dio.dart';
import 'package:titanic_app/models/prediction.dart';
import 'package:titanic_app/models/titanic.dart';
import 'package:titanic_app/utils/constants.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Prediction> prediction(
    Titanic data, {
    required String modelName,
  }) async {
    try {
      final response = await _dio.post(
        apiPredict,
        data: data.toJson(),
        queryParameters: {"model": modelName},
      );

      return Prediction.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data['details'] ?? "Erreur lors de la prediction";
    }
  }
}
