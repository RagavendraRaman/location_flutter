import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Location',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: getLocation(),
    );
  }
}

class getLocation extends StatefulWidget {
  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<getLocation> {
  LocationData? _currentPosition;
  String? _address;
  Location location = new Location();

  @override
  void initState() {
    super.initState();
    // autoRunning();
    fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Location"),
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              if (_currentPosition != null)
                Text(
                  "Latitude: ${_currentPosition!.latitude}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              if (_currentPosition != null)
                Text(
                  "Longitude: ${_currentPosition!.longitude}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              // if (_address != null)
              //   Text(
              //     "Address: $_address",
              //     style: TextStyle(
              //       fontSize: 16,
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }

  void autoRunning() async {

    const time = Duration(seconds: 10);
    Timer.periodic(
        time,
        (Timer t) => {
          fetchLocation(),
              // getPolyPoints(),
              // setCustomMarkerIcon(),
              print('after some delay'),
            });
  }

  fetchLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    print('current Location latitude:::::: ${_currentPosition!.latitude}');
    print('current Location longitude:::::: ${_currentPosition!.longitude}');
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentPosition = currentLocation;
    //       print('current on Location latitude:::::: ${_currentPosition!.latitude}');
    // print('current on Location longitude:::::: ${_currentPosition!.longitude}');
        // getAddress(_currentPosition.latitude, _currentPosition.longitude)
        //     .then((value) {
        //   setState(() {
        //     _address = "${value.first.addressLine}";
        //   });
        // });
      });
    });
  }
  }
  