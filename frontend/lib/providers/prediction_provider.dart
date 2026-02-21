import 'package:flutter/foundation.dart';
import 'package:titanic_app/models/prediction.dart';
import 'package:titanic_app/models/titanic.dart';
import 'package:titanic_app/services/api_service.dart';

class PredictionProvider extends ChangeNotifier {
  final ApiService _apiService;

  bool _isLoading = false;
  Prediction? _prediction;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  Prediction? get prediction => _prediction;
  String? get errorMessage => _errorMessage;

  PredictionProvider(this._apiService);

  Future<void> makePrediction (
    Titanic data, {
    required String modelName,
}
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _apiService.prediction(
        data,
        modelName: modelName,
      );

      _prediction = result;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _prediction = null;
    }finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void resetPrediction() {
    _prediction = null;
    _errorMessage = null;
    notifyListeners();
  }
}