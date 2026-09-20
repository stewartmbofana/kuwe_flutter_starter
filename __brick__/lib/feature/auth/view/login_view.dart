import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{project_name.snakeCase()}}/feature/auth/bloc/auth_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign in to continue',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            _ProviderButton(
              label: 'Continue with Google',
              provider: AuthProvider.google,
            ),
            _ProviderButton(
              label: 'Continue with Facebook',
              provider: AuthProvider.facebook,
            ),
            _ProviderButton(
              label: 'Continue with Twitter',
              provider: AuthProvider.twitter,
            ),
            _ProviderButton(
              label: 'Continue with Apple',
              provider: AuthProvider.apple,
            ),
            _ProviderButton(
              label: 'Continue with Microsoft',
              provider: AuthProvider.microsoft,
            ),
            _ProviderButton(
              label: 'Continue with GitHub',
              provider: AuthProvider.github,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProviderButton extends StatelessWidget {
  const _ProviderButton({required this.label, required this.provider});

  final String label;
  final AuthProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () =>
              context.read<AuthBloc>().add(AuthProviderSelected(provider)),
          child: Text(label),
        ),
      ),
    );
  }
}
