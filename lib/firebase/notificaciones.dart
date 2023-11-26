import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print('Title: ${message.notification?.title}');
  print('Title: ${message.notification?.body}');
  print('Title: ${message.data}');
}

class PushNotificationProvider {
  final _firebaseMessaging = FirebaseMessaging.instance;
  static String? token;

Future<void> initializeApp() async {
  await _firebaseMessaging.requestPermission();
  final token = await _firebaseMessaging.getToken();
  print('Token: $token');
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
}

void handleMessage(RemoteMessage? message) {
  if(message == null) return;


}  

Future initPushNotifications() async {
  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
}

  
    //FirebaseMessaging.instance.getInitialMessage().then((handleMessage));
    //FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    //LocalNotifications.initialize();
    //FirebaseMessaging.onMessage.listen((message) {
      //LocalNotifications.showBigTextNotification(
      //  title: 'Se te va el camion!',
      //  body: 'Corre a tu parada mas cercana!',
      //);
    //});
  }

  /*addNewSubscription(String topic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('currentSub')) {
      var currentTopic = prefs.getString('currentSub');
      await firebaseMessaging.unsubscribeFromTopic(currentTopic!);
      prefs.setString('currentSub', topic);
      await firebaseMessaging.subscribeToTopic(topic);
    } else {
      prefs.setString('currentSub', topic);
      await firebaseMessaging.subscribeToTopic(topic);
    }
  }*/


class LocalNotifications {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future initialize() async {
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationsSettings =
        InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'channel1',
      'fitness_channel',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var not = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, title, body, not);
  }
}