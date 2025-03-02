import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_simple/core/utils/snackbar_helper.dart';
import 'package:todo_app_simple/features/auth/bloc/auth_bloc.dart';
import 'package:todo_app_simple/features/auth/bloc/auth_event.dart';
import 'package:todo_app_simple/features/auth/bloc/auth_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Sign Up', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(hintText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return CircularProgressIndicator();
                }

                return ElevatedButton(
                    onPressed: signup, child: const Text('Sign up'));
              },
              listener: (context, state) {
                if (state is AuthSuccess) {
                  SnackbarHelper.showSuccessMessage(
                      context, "Berhasil mendaftar");
                } else if (state is AuthFailure) {
                  SnackbarHelper.showFailMessage(
                      context, "Gagal mendaftar: $state.error");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void signup() {
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      SnackbarHelper.showFailMessage(context, "Semua field harus diisi!");
      return;
    }

    if (password != confirmPassword) {
      SnackbarHelper.showFailMessage(context, "Password tidak sama!");
      return;
    }

    context.read<AuthBloc>().add(RegisterRequested(email, password));
  }
}
