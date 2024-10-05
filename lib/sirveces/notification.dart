import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class notification {
  static FlutterLocalNotificationsPlugin not = FlutterLocalNotificationsPlugin();

  static ontap(NotificationResponse notfication) {}

  static Future<void> init() async {
    InitializationSettings setting = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings()
    );
    tz.initializeTimeZones();
    not.initialize(
        setting,
        onDidReceiveBackgroundNotificationResponse: ontap,
        onDidReceiveNotificationResponse: ontap
    );
  }

  static void show_notfication() async {
    NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails(
            "1",
            "basic_not"
        )
    );
    await not.show(
      0,
      "Time Out!!!",
      "   ",
      details,
    );
  }

  static Future<void> mission_notification(DateTime? time, String missionText,
      int notificationId) async {
    if (time == null) return;
    DateTime now = DateTime.now();

    if (time.isBefore(now)) {
      now = time.add(Duration(days: 1));
    }

    var androidDetails = AndroidNotificationDetails(
      "mission_id",
      "mission_name",
      importance: Importance.max,
      priority: Priority.high,
    );

    var iosDetails = DarwinNotificationDetails();

    var notificationDetails = NotificationDetails(
        android: androidDetails, iOS: iosDetails);

    await not.zonedSchedule(
      notificationId,
      "Mission Reminder",
      missionText,
      tz.TZDateTime.from(time, tz.local),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation
          .absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
  static Future<void>repeated_not(int id, String? remind_text,DateTime time_of_reminding)async{
    if(time_of_reminding.isBefore(DateTime.now())){
      time_of_reminding=time_of_reminding.add(Duration(days:1));
    }
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_notification_channel_id',
        'Daily Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await not.zonedSchedule(
      id,
      'Remember',
      remind_text,
      tz.TZDateTime.from(time_of_reminding, tz.local),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}















