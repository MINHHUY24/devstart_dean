import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _localNotifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Yêu cầu quyền thông báo
    await _firebaseMessaging.requestPermission();

    // Khởi tạo local notifications
    const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    final InitializationSettings initSettings = InitializationSettings(android: androidInit, iOS: iosInit);
    await _localNotifications.initialize(initSettings);

    // Lắng nghe khi có thông báo
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        _localNotifications.show(
          0,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails('channel_id', 'Thông báo', importance: Importance.high, priority: Priority.high),
            iOS: DarwinNotificationDetails(),
          ),
        );
      }
    });

    // Lắng nghe token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print('Token FCM được làm mới: $newToken');
    });

    // Lấy token ban đầu
    try {
      final token = await _firebaseMessaging.getToken();
      print("Token Firebase: $token");
    } catch (e) {
      print('Lấy token FCM thất bại: $e');
    }
  }

  static Future<void> _enableNotifications() async {
    if (Platform.isIOS) {
      bool ready = await _waitForApnsToken();
      if (!ready) {
        print('APNs token chưa sẵn sàng. Không thể bật thông báo.');
        return;
      }
    }

    try {
      await _firebaseMessaging.requestPermission();
      final token = await _firebaseMessaging.getToken();
      print('Đã bật thông báo. Token: $token');

      await NotificationSettings.setNotificationEnabled(true);
    } catch (e) {
      print('Lỗi khi bật thông báo: $e');
    }
  }

  static Future<void> _disableNotifications() async {
    if (Platform.isIOS) {
      bool ready = await _waitForApnsToken();
      if (!ready) {
        print('⚠️ APNs token chưa sẵn sàng. Không thể xoá token.');
        return;
      }
    }

    try {
      await _firebaseMessaging.deleteToken();
      print('Đã tắt thông báo, token đã bị xóa');

      await NotificationSettings.setNotificationEnabled(false);
    } catch (e) {
      print('Lỗi khi tắt thông báo: $e');
    }
  }

  static Future<void> toggleNotifications(bool enable) async {
    if (enable) {
      await _enableNotifications();
    } else {
      await _disableNotifications();
    }
  }

  /// Hàm đợi APNs token sẵn sàng trong tối đa 5 giây
  static Future<bool> _waitForApnsToken({int timeoutMs = 5000, int intervalMs = 200}) async {
    final stopwatch = Stopwatch()..start();
    while (stopwatch.elapsedMilliseconds < timeoutMs) {
      final token = await _firebaseMessaging.getAPNSToken();
      if (token != null) {
        print("✅ APNs Token is ready: $token");
        return true;
      }
      await Future.delayed(Duration(milliseconds: intervalMs));
    }
    print('⏳ Hết thời gian chờ APNs token (${timeoutMs}ms)');
    return false;
  }
}

class NotificationSettings {
  static const _keyIsNotificationEnabled = 'isNotificationEnabled';

  static Future<bool> isNotificationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsNotificationEnabled) ?? true; // Mặc định bật
  }

  static Future<void> setNotificationEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsNotificationEnabled, enabled);
  }
}
