import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:titanic_app/providers/prediction_provider.dart';
import 'package:titanic_app/services/api_service.dart';
import 'package:titanic_app/utils/constants.dart';
import 'package:titanic_app/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  setupEnv();

  final sharedDio = Dio(BaseOptions(baseUrl: apiBaseUrl));
  final apiService = ApiService(sharedDio);
  final predictionProvider = PredictionProvider(apiService);

  runApp(MyApp(predictionProvider: predictionProvider));
}

class MyApp extends StatelessWidget {
  final PredictionProvider predictionProvider;

  const MyApp({super.key, required this.predictionProvider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PredictionProvider>.value(
      value: predictionProvider,
      child: MaterialApp(
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
