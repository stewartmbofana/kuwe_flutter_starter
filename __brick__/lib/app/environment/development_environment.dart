import 'package:{{project_name.snakeCase()}}/app/environment/app_environment.dart';

final class DevelopmentEnvironment implements AppEnvironment {
  @override
  String get baseUrl => 'https://example.com';
}
