import 'dart:convert';

import 'package:cnss_djibouti_app/configs/ApiConnexion.dart';
import 'package:cnss_djibouti_app/models/Communique.dart';

import 'screens/splash.dart' show splash;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();
void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
    // The top level function, aka callbackDispatcher
    callbackDispatcher,

    // If enabled it will post a notification whenever
  );
  // Periodic task registration
  Workmanager().registerPeriodicTask(
    "1",

    //This is the value that will be
    // returned in the callbackDispatcher
    "cnssTask",
    existingWorkPolicy: ExistingWorkPolicy.replace,
    initialDelay:
        Duration(seconds: 5), //duration before showing the notification
    // When no frequency is provided
    // the default 15 minutes is set.
    // Minimum frequency is 15 min.
    // Android will automatically change
    // your frequency to 15 min
    // if you have configured a lower frequency.
    frequency: Duration(minutes: 15),
  );
  runApp(MyApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    futureListeCommunique = fetchListeCommunique();
    List<dynamic> communiqueList = await futureListeCommunique;
    Communique lastCommunique = communiqueList.last;
    // initialise the plugin of flutterlocalnotifications.
    FlutterLocalNotificationsPlugin flip =
        new FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = new AndroidInitializationSettings('ic_launcher');
    var IOS = new IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = new InitializationSettings(android: android, iOS: IOS);
    flip.initialize(settings);
    // check if is within last 15minutes
    DateTime now = DateTime.now();
    Duration difference = now.difference(
        DateTime.parse(lastCommunique.created_at.toString().substring(0, 10)));
    logger.i(difference.toString());
    logger.i(difference.inMinutes.toString());
    logger.i(lastCommunique.title.toString());
    logger.i(lastCommunique.created_at.toString().substring(0, 10).toString());
    if (difference.inMinutes <= 30) {
      _showNotificationWithDefaultSound(flip, lastCommunique);
    }
    return Future.value(true);
  });
}

late Future<List<Communique>> futureListeCommunique;
Future<List<Communique>> fetchListeCommunique() async {
  final response =
      await http.get(Uri.parse(ApiConnexion.baseUrl + '/communiques'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Communique>((json) => Communique.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

Future _showNotificationWithDefaultSound(
    flip, Communique lastCommunique) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flip.show(
    0,
    lastCommunique.title,
    lastCommunique.body,
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CNSS-APP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: splash());
  }
}
