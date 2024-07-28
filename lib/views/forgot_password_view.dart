// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_services.dart';
import 'package:mynotes/utilities/dialog_box.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot and Reset Password'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'If you forgot your password, simply enter your email and we will send you a password reset link.',
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email here',
                ),
              ),
              TextButton(
                onPressed: () async {
                  final email = _textController.text;
                  await AuthService.firebase()
                      .sendPasswordReset(toEmail: email);
                  await showPasswordResetSentDialog(context);
                },
                child: const Text(
                  'Send me password reset link',
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Back to login page',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
