//import 'dart:js';
import 'dart:async';
import 'package:flutter/services.dart';
//import 'package:flutter_telephony/flutter_telephony.dart';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/childpage.dart' as loc;
import 'package:flutter_auth/providers/authListener.dart';
import 'package:flutter_auth/rangeapp.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_auth/Screens/Home/notification.dart' as notif;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  Workmanager().registerPeriodicTask(
    "1",
    "fetchBackground",
    initialDelay: Duration(minutes: 1),
    frequency: Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
  runApp(Main());
}

//void main() => runApp(Main());

callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case "fetchBackground":
        Position userLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true);
        notif.Notification notification = notif.Notification();
        notification.showNotificationWithoutSound(userLocation);
        //Widget? build(BuildContext context) {
        //if (Provider.of<AuthListen>(context, listen: true).isChild == false) {
        var lang = userLocation.longitude.toDouble();
        var lat = userLocation.latitude.toDouble();
        loc.Location location = loc.Location();
        location.getAddress(lat, lang);
        //  }
        // }

        print(userLocation.longitude);

        break;
    }
    return Future.value(true);
  });
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider.of<AuthListen>(context, listen: true).isChild;
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthListen()),
    ], child: RangeApp());
  }
}
