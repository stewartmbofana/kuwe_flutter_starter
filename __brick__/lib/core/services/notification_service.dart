import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {
  Future<void> initialize() async {
    await FirebaseMessaging.instance.requestPermission();
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('FirebaseMessaging token: $token');

    await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    await OneSignal.initialize('YOUR_ONESIGNAL_APP_ID');
    await OneSignal.Notifications.requestPermission(true);
  }
}
