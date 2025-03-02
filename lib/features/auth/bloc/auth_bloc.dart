import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_simple/core/services/auth_services.dart';
import 'package:todo_app_simple/features/auth/bloc/auth_event.dart';
import 'package:todo_app_simple/features/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthServices authServices = AuthServices();

  AuthBloc({required this.authServices}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        await authServices.login(event.email, event.password);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        await authServices.register(event.email, event.password);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await authServices.logout();
      emit(AuthInitial());
    });
  }
}
