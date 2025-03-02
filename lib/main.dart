import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_simple/core/services/auth_services.dart';
import 'package:todo_app_simple/features/auth/bloc/auth_bloc.dart';
import 'package:todo_app_simple/features/auth/view/login_page.dart';
import 'package:todo_app_simple/features/todo/view/home_page.dart';

void main() {
  final AuthServices authServices = AuthServices();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authServices: authServices),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      )));
}
