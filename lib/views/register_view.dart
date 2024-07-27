// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exception.dart';
import 'package:mynotes/services/auth/auth_services.dart';
import 'package:mynotes/utilities/dialog_box.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

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
        title: const Text('Register'),
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
            autocorrect: false,
            enableSuggestions: false,
            obscureText: true,
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                await AuthService.firebase().createUser(email: email, password: password,);
                final user = AuthService.firebase().currentUser;
                if (user != null) {
                  AuthService.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                }
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  context, 'The password provided is too weak.');
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                  context, 'The provided email is already in use.');
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  context, 'The provided email is invalid');
              } on GenericAuthException {
                await showErrorDialog(context, 'Error: Authentication error');
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already have an account? Login here...'),
          ),
        ],
      ),
    );
  }
}
