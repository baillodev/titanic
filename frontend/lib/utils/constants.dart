import 'package:flutter_dotenv/flutter_dotenv.dart';

const String apiPredict = "/api/predict";

late final String apiBaseUrl;

void setupEnv() {
  apiBaseUrl = dotenv.env['API_BASE_URL'] ?? "http://127.0.0.1:8000";
}
