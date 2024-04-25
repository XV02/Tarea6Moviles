import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image.asset(
              "assets/icons/app_icon.png",
              height: 120,
            ),
            const SizedBox(height: 200),
            MaterialButton(
              color: Colors.grey,
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(AnonymousAuthEvent());
              },
              child: const Text("Iniciar como anonimo"),
            ),
            const Text(
              "Utiliza un red social",
            ),
            MaterialButton(
              color: Colors.green,
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
              },
              child: const Text("Iniciar con Google"),
            ),
          ],
        ),
      ),
    );
  }
}
