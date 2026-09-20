import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:{{project_name.snakeCase()}}/core/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthService authService})
    : _authService = authService,
      super(const AuthState.initial()) {
    on<AuthSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthProviderSelected>(_onProviderSelected);
    on<AuthSignOutRequested>(_onSignOutRequested);
  }

  final AuthService _authService;
  StreamSubscription<User?>? _authSubscription;

  Future<void> _onSubscriptionRequested(
    AuthSubscriptionRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    await _authSubscription?.cancel();
    _authSubscription = _authService.authStateChanges.listen((user) {
      add(AuthUserChanged(user));
    });
    emit(const AuthState.unauthenticated());
  }

  Future<void> _onProviderSelected(
    AuthProviderSelected event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      switch (event.provider) {
        case AuthProvider.google:
          await _authService.signInWithGoogle();
        case AuthProvider.facebook:
          await _authService.signInWithFacebook();
        case AuthProvider.twitter:
          await _authService.signInWithTwitter();
        case AuthProvider.apple:
          await _authService.signInWithApple();
        case AuthProvider.microsoft:
          await _authService.signInWithMicrosoft();
        case AuthProvider.github:
          await _authService.signInWithGitHub();
      }
      emit(const AuthState.authenticated());
    } catch (error) {
      emit(AuthState.failure(error.toString()));
    }
  }

  Future<void> _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authService.signOut();
      emit(const AuthState.unauthenticated());
    } catch (error) {
      emit(AuthState.failure(error.toString()));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
