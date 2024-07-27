// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exception.dart';
import 'package:mynotes/services/auth/auth_services.dart';
import 'package:mynotes/utilities/dialog_box.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
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
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: _password,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextButton(
            onPressed: () async {
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
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, registerRoute, (router) => false);
            },
            child: const Text('Don\'t have an account? Register here!'),
          ),
        ],
      ),
    );
  }
}
