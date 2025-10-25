import 'package:flutter/material.dart';
import 'package:notification_log/models/icons.dart';
import 'package:notification_log/models/notification_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.model});
  final NotificationModel model;

  @override
  Widget build(BuildContext context) {
    String agoVal = timeago.format(
      DateTime.fromMillisecondsSinceEpoch(model.timestamp),
      locale: 'en_short',
    );
    if (agoVal != 'now') {
      agoVal = '$agoVal ago';
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Optional: App Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Icon(IconsFetcher.getIcon(model.appName), size: 24),
              ),
            ),
            const SizedBox(width: 12),
            // Notification info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(model.content, style: TextStyle(fontSize: 14)),

                  const SizedBox(height: 4),
                  Text(model.appName, style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 6),
                  Text(
                    agoVal,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
