class NotificationModel {
  final String appName;
  final String title;
  final String content;
  final int timestamp;

  NotificationModel({
    required this.appName,
    required this.title,
    required this.content,
    required this.timestamp,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      appName: map['appName'] ?? 'Unknown',
      title: map['title'] ?? 'Unknown',
      content: map['content'] ?? 'Unknown',
      timestamp: map['timestamp'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appName': appName,
      'title': title,
      'content': content,
      'timestamp': timestamp,
    };
  }
}
