import 'package:notification_log/models/notification_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._con();
  DatabaseService._con();
  Future<void> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notifications.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notifications(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            appName TEXT,
            title TEXT,
            content TEXT,
            timestamp INTEGER
          )
        ''');
        await db.execute('CREATE INDEX idx_appName ON notifications(appName)');
        await db.execute(
          'CREATE INDEX idx_timestamp ON notifications(timestamp)',
        );
      },
    );
  }

  Future<void> insertNotification(NotificationModel notification) async {
    await _db?.insert('notifications', notification.toMap());
  }

  Future<List<NotificationModel>> getAllNotifications() async {
    final data = await _db!.query('notifications', orderBy: 'timestamp DESC');
    return data.map((e) => NotificationModel.fromMap(e)).toList();
  }
}
