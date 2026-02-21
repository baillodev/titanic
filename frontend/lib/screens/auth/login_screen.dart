import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:titanic_app/models/user_models.dart';
import 'package:titanic_app/providers/auth_provider.dart';
import 'package:titanic_app/screens/auth/register_screen.dart';
import 'package:titanic_app/screens/home_screen.dart';
import 'package:titanic_app/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      final data = UserCredentials(
        username: _usernameController.text,
        password: _passwordController.text,
      );

      Provider.of<AuthProvider>(context, listen: false).login(data);

      _formKey.currentState!.reset();
      nextPage(HomeScreen(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), backgroundColor: Colors.blue, foregroundColor: Colors.white,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 15,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez entrer une valeur";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez entrer une valeur";
                        }
                        return null;
                      },
                      obscureText: _showPassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _toggleShowPassword,
                        ),
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Pas encore incrit ?"),
                        TextButton(
                          onPressed: () {
                            nextPage(RegisterScreen(), context);
                          },
                          child: Text("S'inscrire"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
