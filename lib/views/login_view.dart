// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exception.dart';
import 'package:mynotes/services/auth/auth_services.dart';
import 'package:mynotes/utilities/dialog_box.dart';
import 'package:mynotes/views/loading_screen.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final OverlayManager _overlayManager = OverlayManager();
  bool _isEmailVerified = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                'assets/profile.png',
                height: 150,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _email,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _password,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              const SizedBox(height: 20.0),
              _buildGradientButton('Login', () async {
                await _overlayManager.simulateLoadingProcess(context, () async {
                  await Future.delayed(const Duration(seconds: 2));
                });
                final email = _email.text;
                final password = _password.text;
                try {
                  await AuthService.firebase()
                      .logIn(email: email, password: password);

                  final user = AuthService.firebase().currentUser;
                  if (user != null) {
                    setState(() {
                      _isEmailVerified = user.isEmailVerified;
                    });
                  }

                  if (_isEmailVerified) {
                    Navigator.pushReplacementNamed(context, notesRoute);
                  } else {
                    showEmailNotVerifiedDialog(context);
                  }
                } on ChannelErrorAuthException {
                  await showErrorDialog(
                      context, 'Credentials are required for this action');
                } on InvalidCredentialsAuthException {
                  await showErrorDialog(
                      context, 'The provided auth credential is invalid');
                } on GenericAuthException {
                  await showErrorDialog(context, 'Error: Authentication error');
                }
              }),
              const SizedBox(height: 10.0),
              _buildGradientButton('Forgot Password?', () async {
                await _overlayManager.simulateLoadingProcess(context, () async {
                  await Future.delayed(const Duration(seconds: 2));
                });
                Navigator.pushNamed(context, forgotPasswordRoute);
              }),
              const SizedBox(height: 10.0),
              _buildGradientButton('Don\'t have an account? Register here!', () async {
                await _overlayManager.simulateLoadingProcess(context, () async {
                  await Future.delayed(const Duration(seconds: 2));
                });
                Navigator.pushNamedAndRemoveUntil(
                    context, registerRoute, (router) => false);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.blueAccent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
