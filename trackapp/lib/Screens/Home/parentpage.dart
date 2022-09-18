import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auth/authentication/authFunctions.dart';

class Parent extends StatelessWidget {
  const Parent({
    Key? key,
    required this.phone,
    required this.location,
    required this.battery,
  }) : super(key: key);
  final String phone;
  final String location;
  final String battery;
  static const String _title = 'TrackApp';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: Text(_title)),
        body: MyStatefulWidget(
          phone: phone,
          loc: location,
          bat: battery,
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({
    Key? key,
    required this.phone,
    required this.loc,
    required this.bat,
  }) : super(key: key);
  final String phone;
  final String loc;
  final String bat;
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var resp = Auth.locationChild();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.phone),
                title: Text(widget.phone),
                subtitle: Text(widget.loc),
                trailing: Text(widget.bat)),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   // children: <Widget>[
            //   //   TextButton(
            //   //     child: const Text('BUY TICKETS'),
            //   //     onPressed: () {/* ... */},
            //   //   ),
            //   //   const SizedBox(width: 8),
            //   //   TextButton(
            //   //     child: const Text('LISTEN'),
            //   //     onPressed: () {
            //   //       /* ... */
            //   //     },
            //     ),
            // const SizedBox(width: 8),
            // ],
            // ),
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
