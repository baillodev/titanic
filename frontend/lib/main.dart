import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:titanic_app/providers/auth_provider.dart';
import 'package:titanic_app/providers/prediction_provider.dart';
import 'package:titanic_app/services/api_service.dart';
import 'package:titanic_app/services/auth_service.dart';
import 'package:titanic_app/utils/constants.dart';
import 'package:titanic_app/widgets/auth_check_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  setupEnv();

  final sharedDio = Dio(BaseOptions(baseUrl: apiBaseUrl));

  final authService = AuthService(sharedDio);
  final apiService = ApiService(sharedDio, authService);

  final authProvider = AuthProvider(authService);
  final predictionProvider = PredictionProvider(apiService);

  runApp(
    MyApp(authProvider: authProvider, predictionProvider: predictionProvider),
  );
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;
  final PredictionProvider predictionProvider;

  const MyApp({
    super.key,
    required this.authProvider,
    required this.predictionProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
        ChangeNotifierProvider<PredictionProvider>.value(
          value: predictionProvider,
        ),
      ],

      child: MaterialApp(
        home: AuthCheckWidget(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
