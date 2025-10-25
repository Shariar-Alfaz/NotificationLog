package com.example.notification_log

import android.content.Context   
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import io.flutter.plugin.common.EventChannel

class NotificationListener : NotificationListenerService(){
    companion object {
        var eventSink: EventChannel.EventSink? = null
    }

    override fun onNotificationPosted(sbn: StatusBarNotification) {
        val pkg = sbn.packageName
        val title = sbn.notification.extras.getString("android.title") ?: "No Title"
        val text = sbn.notification.extras.getCharSequence("android.text")?.toString() ?: "No Content"
        val time = sbn.postTime

        val data = mapOf(
            "appName" to pkg,
            "title" to title,
            "content" to text,
            "timestamp" to time
        )

        saveNotificationToDB(applicationContext, pkg, title, text, time)
        eventSink?.success(data)
    }

    override fun onListenerConnected() {
        super.onListenerConnected()
    }

    override fun onListenerDisconnected() {
        super.onListenerDisconnected()
    }
    
    private fun saveNotificationToDB(context: Context, pkg: String, title: String, text: String, time: Long) {
        val dbHelper = NotificationDbHelper(context)
        dbHelper.insertNotification(pkg, title, text, time)
    }
}