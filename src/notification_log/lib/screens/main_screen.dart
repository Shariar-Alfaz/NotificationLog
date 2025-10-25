import 'package:flutter/material.dart';
import 'package:notification_log/models/notification_model.dart';
import 'package:notification_log/services/database_service.dart';
import 'package:notification_log/services/notification_listener_service.dart';
import 'package:notification_log/services/notification_permission.dart';
import 'package:notification_log/widgets/notification_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  List<NotificationModel> _notifications = [];
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await DatabaseService.instance.init();
    final data = await DatabaseService.instance.getAllNotifications();
    setState(() => _notifications = data);

    NotificationListenerService.startListening((notif) {
      setState(() => _notifications.insert(0, notif));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Log')),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await NotificationPermission.requestPermission();
                    },
                    child: const Text('Request Permission'),
                  ),
                  const Text('No notifications yet'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return NotificationCard(model: _notifications[index]);
              },
            ),
    );
  }
}
