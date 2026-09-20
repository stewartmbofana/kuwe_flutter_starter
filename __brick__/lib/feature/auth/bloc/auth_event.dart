part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthSubscriptionRequested extends AuthEvent {
  const AuthSubscriptionRequested();
}

class AuthUserChanged extends AuthEvent {
  const AuthUserChanged(this.user);

  final User? user;

  @override
  List<Object?> get props => [user];
}

class AuthProviderSelected extends AuthEvent {
  const AuthProviderSelected(this.provider);

  final AuthProvider provider;

  @override
  List<Object?> get props => [provider];
}

class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}

enum AuthProvider {
  google,
  facebook,
  twitter,
  apple,
  microsoft,
  github,
}
