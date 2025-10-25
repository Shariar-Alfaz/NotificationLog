import 'package:flutter/services.dart';
import 'package:notification_log/models/notification_model.dart';

class NotificationListenerService {
  static const _eventChanel = EventChannel('notification_log_channel');
  static void startListening(Function(NotificationModel) onNotification) {
    _eventChanel.receiveBroadcastStream().listen((event) async {
      final notif = NotificationModel.fromMap(Map<String, dynamic>.from(event));
      //await DatabaseService.instance.insertNotification(notif);
      onNotification(notif);
    });
  }
}
