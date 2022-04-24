import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: LocationWidget(),
    );
  }
}

class LocationWidget extends StatefulWidget {
  const LocationWidget({Key? key}) : super(key: key);

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  var permission;
  void getCurrentPosition() async {
    try {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        try {
          permission = await Geolocator.requestPermission();
        } catch (e) {
          print("Permission denied by user");
        }
      }
    } catch (e) {
      print(e);
    }
    Position MyPos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    print(MyPos.latitude);
    print(MyPos.longitude);
  }

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Geolocator')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                getCurrentPosition();
              });
            },
            child: Text("Current Location"),
          ),
        ));
  }
}
