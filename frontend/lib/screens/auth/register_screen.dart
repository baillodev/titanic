import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:titanic_app/models/user_models.dart';
import 'package:titanic_app/providers/auth_provider.dart';
import 'package:titanic_app/screens/auth/login_screen.dart';
import 'package:titanic_app/screens/home_screen.dart';
import 'package:titanic_app/utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _showPassword = true;
  bool _showConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      final data = UserCredentials(
        username: _usernameController.text,
        password: _passwordController.text,
      );

      Provider.of<AuthProvider>(context, listen: false).register(data);

      _formKey.currentState!.reset();

      nextPage(HomeScreen(), context);
    }
  }

  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
  void _toggleShowConfirmPassword() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register"), backgroundColor: Colors.blue, foregroundColor: Colors.white,),
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
                    TextFormField(
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez entrer une valeur";
                        }
                        if(value != _passwordController.text) {
                          return "Les mots sont diffrents";
                        }
                        return null;
                      },
                      obscureText: _showConfirmPassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _toggleShowConfirmPassword,
                        ),
                        labelText: "Confirm Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: _register,
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
                          "Register",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Vous avez un compte ?"),
                        TextButton(
                          onPressed: () {
                            nextPage(LoginScreen(), context);
                          },
                          child: Text("Se connecter"),
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
