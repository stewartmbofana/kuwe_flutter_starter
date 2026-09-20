import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:{{project_name.snakeCase()}}/app/environment/app_environment.dart';
import 'package:{{project_name.snakeCase()}}/core/clients/network/network_client.dart';
import 'package:{{project_name.snakeCase()}}/core/services/auth_service.dart';
import 'package:{{project_name.snakeCase()}}/core/services/notification_service.dart';

/// [Locator] is responsible for locating and registering all the
/// services of the application.
abstract final class Locator {
  /// [GetIt] instance
  @visibleForTesting
  static final instance = GetIt.instance;

  /// Returns instance of [NetworkClient]
  static NetworkClient get networkClient => instance<NetworkClient>();

  /// Returns instance of [AuthService]
  static AuthService get authService => instance<AuthService>();

  /// Returns instance of [NotificationService]
  static NotificationService get notificationService =>
      instance<NotificationService>();

  /// Responsible for registering all the dependencies
  static Future<void> locateServices({
    required AppEnvironment environment,
  }) async {
    instance
      // Clients
      ..registerLazySingleton(
        () => NetworkClient(dio: instance(), baseUrl: environment.baseUrl),
      )
      ..registerLazySingleton(AuthService.new)
      ..registerLazySingleton(NotificationService.new)
      // Client Dependencies
      ..registerFactory(Dio.new);
  }
}
