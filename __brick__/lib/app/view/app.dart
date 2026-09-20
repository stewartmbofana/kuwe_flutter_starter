import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{project_name.snakeCase()}}/app/constants/string_constants.dart';
import 'package:{{project_name.snakeCase()}}/app/l10n/l10n.dart';
import 'package:{{project_name.snakeCase()}}/app/theme/dark/dark_theme.dart';
import 'package:{{project_name.snakeCase()}}/app/theme/light/light_theme.dart';
import 'package:{{project_name.snakeCase()}}/feature/auth/bloc/auth_bloc.dart';
import 'package:{{project_name.snakeCase()}}/feature/auth/view/auth_gate.dart';
import 'package:{{project_name.snakeCase()}}/locator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) =>
          AuthBloc(authService: Locator.authService)
            ..add(const AuthSubscriptionRequested()),
      child: MaterialApp(
        title: StringConstants.appName,
        theme: LightTheme().theme,
        darkTheme: DarkTheme().theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const AuthGate(),
      ),
    );
  }
}
