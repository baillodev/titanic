import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:titanic_app/providers/auth_provider.dart';
import 'package:titanic_app/screens/auth/login_screen.dart';
import 'package:titanic_app/screens/home_screen.dart';

class AuthCheckWidget extends StatelessWidget {
  const AuthCheckWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (authProvider.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }else if(authProvider.isLoggedIn) {
      return HomeScreen();
    }else {
      return const LoginScreen();
    }
  }
}