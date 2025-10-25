import 'package:flutter/services.dart';

class NotificationPermission {
  static const MethodChannel _channel = MethodChannel(
    'notification_permission_channel',
  );

  static Future<void> requestPermission() async {
    try {
      await _channel.invokeMethod('requestPermission');
    } on PlatformException catch (e) {
      print("Error permissioon $e");
    }
  }
}
