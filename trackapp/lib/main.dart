//import 'dart:js';

import 'dart:convert';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/iso_battery_info.dart';

import 'dart:async';
import 'package:flutter/services.dart';
//import 'package:flutter_telephony/flutter_telephony.dart';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/childpage.dart' as loc;
import 'package:flutter_auth/authentication/authFunctions.dart';
import 'package:flutter_auth/providers/authListener.dart';
import 'package:flutter_auth/rangeapp.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    frequency: Duration(minutes: 10),
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

        var battery =
            (await BatteryInfoPlugin().androidBatteryInfo)!.batteryLevel;
        print(battery);
        //Widget? build(BuildContext context) {
        //if (Provider.of<AuthListen>(context, listen: true).isChild == false) {
        var lang = userLocation.longitude.toDouble();
        var lat = userLocation.latitude.toDouble();

        //GeoCode geoCode = GeoCode();
        Address address =
            await GeoCode().reverseGeocoding(latitude: lat, longitude: lang);
        var add = address.city;
        SharedPreferences shared_User = await SharedPreferences.getInstance();
        var user = shared_User.getString('user');
        var obj = jsonDecode(user!);
        var pc = await Auth.callParentCheck(phone: obj['phone']);
        if (pc['msg'] == "CHILD") {
          print("child");
          var res =
              await Auth.updateLocationBattery(location: add, battery: battery);
        }
        // var googleGeocoding =
        //     GoogleGeocoding("");
        // var address =
        //     await googleGeocoding.geocoding.getReverse(LatLon(lat, lang));
        // print(address);
// var placemarks = await _geolocator.placemarkFromCoordinates(lat, lang);
//     var address ='${placemarks.first.name.isNotEmpty ? placemarks.first.name + ', ' : ''}${placemarks.first.thoroughfare.isNotEmpty ? placemarks.first.thoroughfare + ', ' : ''}${placemarks.first.subLocality.isNotEmpty ? placemarks.first.subLocality+ ', ' : ''}${placemarks.first.locality.isNotEmpty ? placemarks.first.locality+ ', ' : ''}${placemarks.first.subAdministrativeArea.isNotEmpty ? placemarks.first.subAdministrativeArea + ', ' : ''}${placemarks.first.postalCode.isNotEmpty ? placemarks.first.postalCode + ', ' : ''}${placemarks.first.administrativeArea.isNotEmpty ? placemarks.first.administrativeArea : ''}';
//     print("latitude"+lat);
//     print("longitude"+lang);
//     print("adreess"+address);
        // List<Placemark> placemarks = await placemarkFromCoordinates(lat, lang);
        // print(placemarks);

        //loc.Location location = loc.Location();
        // location.getAddress(lat, lang, battery);

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
