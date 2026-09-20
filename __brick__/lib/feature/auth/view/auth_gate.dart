import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{project_name.snakeCase()}}/feature/auth/bloc/auth_bloc.dart';
import 'package:{{project_name.snakeCase()}}/feature/auth/view/login_view.dart';
import 'package:{{project_name.snakeCase()}}/feature/dashboard/view/dashboard_view.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.loading ||
            state.status == AuthStatus.initial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state.status == AuthStatus.authenticated) {
          return const DashboardView();
        }
        return const LoginView();
      },
    );
  }
}
