package com.example.notification_log

import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import android.content.ContentValues

class NotificationDbHelper(context:Context): SQLiteOpenHelper(context, DATABASE_NAME, null, DATABASE_VERSION){
companion object {
        private const val DATABASE_NAME = "notifications.db"
        private const val DATABASE_VERSION = 1
        private const val TABLE_NAME = "notifications"
        private const val COL_ID = "id"
        private const val COL_PACKAGE = "appName"
        private const val COL_TITLE = "title"
        private const val COL_CONTENT = "content"
        private const val COL_TIMESTAMP = "timestamp"
    }
    
    override fun onCreate(db: SQLiteDatabase) {
    
        val createTable = """
            CREATE TABLE $TABLE_NAME (
                $COL_ID INTEGER PRIMARY KEY AUTOINCREMENT,
                $COL_PACKAGE TEXT,
                $COL_TITLE TEXT,
                $COL_CONTENT TEXT,
                $COL_TIMESTAMP INTEGER
            )
        """.trimIndent()
        db.execSQL(createTable)
    }

    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
        db.execSQL("DROP TABLE IF EXISTS $TABLE_NAME")
        onCreate(db)
    }

    fun insertNotification(pkg: String, title: String, content: String, timestamp: Long) {
        val db = writableDatabase
        val values = ContentValues().apply {
            put(COL_PACKAGE, pkg)
            put(COL_TITLE, title)
            put(COL_CONTENT, content)
            put(COL_TIMESTAMP, timestamp)
        }
        db.insert(TABLE_NAME, null, values)
    }

     fun isDatabaseExists(context: Context): Boolean {
            return context.getDatabasePath(DATABASE_NAME).exists()
        }
}