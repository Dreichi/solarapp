import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'src/locations.dart' as locations;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
  }

  class _MainPageState extends State<MainPage> {
  late GoogleMapController mapController;

  var currentLocation;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((currloc) {
      setState(() {
        currentLocation = currloc;
      });
      mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(currentLocation.latitude, currentLocation.longitude), 12));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        appBar: AppBar(
    ),
    body: GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: LatLng(50.283333, 2.783333),
        zoom: 12,
      ),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
    Navigator.pushNamed(context, '/profile');
    },
        tooltip: 'Mon profil',
        child: const Icon(Icons.person),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
