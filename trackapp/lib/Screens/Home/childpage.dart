import 'dart:convert';
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/parentpage.dart';
import 'package:flutter_auth/Screens/Login/components/login_form.dart';
import 'package:flutter_auth/authentication/authFunctions.dart';
import 'package:flutter_auth/main.dart';
import 'package:flutter_auth/providers/authListener.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
//import 'package:flutter_auth/notification.dart' as notif;

// const fetchBackground = "fetchBackground";
// loc() {
// var userLocation = callbackDispatcher().userLocation;
// var lang = userLocation.longitude;
// var lat = userLocation.latitude;
// // }
// loc() {
//   print(lat);
// }
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     switch (task) {
//       case fetchBackground:
//         // Geolocator geoLocator = Geolocator()..forceAndroidLocationManager = true;
//  Position userLocation = await Geolocator.getCurrentPosition(
//      desiredAccuracy: LocationAccuracy.high);
//var userLocation = callbackDispatcher();
//         //notif.Notification notification = new notif.Notification();
//         // notification.showNotificationWithoutSound(userLocation);
// func() {
//   // print(userLocation);
//   callbackDispatcher();
// }

// var res = Auth.updateLocation(
//   location: userLocation,
// );

//         break;
//     }

class Location {
  Future getAddress(double? lat, double? lang, int? level) async {
    print(lang);
    print(lat);
    //if (lat != null && lang != null) {
    var googleGeocoding =
        GoogleGeocoding("AIzaSyAvfsq8qrODatb8LJTR3fIgjt2WpqmbW4c");
    var address =
        await googleGeocoding.geocoding.getReverse(LatLon(lat!, lang!));

    // GeoCode geoCode = GeoCode();
    // Address address =
    //     await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
    print("Hi");
    print(address);
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    var user = shared_User.getString('user');
    var obj = jsonDecode(user!);
    var pc = await Auth.callParentCheck(phone: obj['phone']);
    if (pc['msg'] == "CHILD") {
      print("child");
      var res =
          await Auth.updateLocationBattery(location: address, battery: level);
    }
  }
  // return "";
}
//}
//     return Future.value(true);
//   });
// }

class Child extends StatelessWidget {
  const Child({
    Key? key,
    required this.phone,
  }) : super(key: key);
  final String phone;
  static const String _title = 'TrackApp';

  // Future<String> _getAddress(double? lat, double? lang) async {
  //   if (lat == null || lang == null) return "";
  //   GeoCode geoCode = GeoCode();
  //   Address address =
  //       await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
  //   var res = await Auth.updateLocation(
  //     location: address,
  //   );
  //   return "${address.streetAddress}, ${address.city}, ${address.countryName}, ${address.postal}";
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(phone: phone),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key, required this.phone}) : super(key: key);
  final String phone;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  void initState() {
    super.initState();

    // Workmanager().initialize(
    //   callbackDispatcher,
    //   isInDebugMode: true,
    // );
    // var userLocation = callbackDispatcher();
    // var lang = userLocation.longitude;
    // var lat = userLocation.latitude;

    // Future<String> _getAddress(double? lat, double? lang) async {
    //   if (lat == null || lang == null) return "";
    //   GeoCode geoCode = GeoCode();
    //   Address address =
    //       await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
    //   var res = await Auth.updateLocation(
    //     location: address.city,
    //   );
    //   return "${address.streetAddress}, ${address.city}, ${address.countryName}, ${address.postal}";
    // }

    // var res = Auth.updateLocation(
    //   location: address,
    // );
    // Workmanager().registerPeriodicTask(
    //   "1",
    //   fetchBackground,
    //   frequency: const Duration(minutes: 15),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album),
              title: Text(widget.phone),
              subtitle: Text('Your location is being tarcked by YOUR PARENT'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Location'),
                  onPressed: () {
                    // loc(); /* ... */
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
