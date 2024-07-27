import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_services.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
                "We've send verification link on your email. Please verify it. After verification login to your account."),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
                "If you haven't receive email then click on below button to send verification link"),
            const SizedBox(
              height: 10.0,
            ),
            TextButton(
              onPressed: () async {
                final user = AuthService.firebase().currentUser;
                if (user != null) {
                  await AuthService.firebase().sendEmailVerification();
                }
              },
              child: const Text("Send Verification."),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (context) => false);
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}