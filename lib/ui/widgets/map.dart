import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';

class MapGoogle extends StatefulWidget {
  const MapGoogle({super.key});

  @override
  State<MapGoogle> createState() => _MapGoogleState();
}

class _MapGoogleState extends State<MapGoogle> {
  late GoogleMapController mapController;
  double? latitude;
  double? longitude;
  late LatLng _center;
  final double offsetLat = -0.008;
  // double? latitude = double.tryParse(HomePage.latitude);  
  // double? longitude = double.tryParse(HomePage.longitude);  
  // final LatLng _center = LatLng(latitude!, longitude!);
  // final double offsetLat = -0.008; // Sesuaikan offset sesuai kebutuhan

  late LatLng targetLatLng;

  @override
  void initState() {
    latitude = double.tryParse(HomePage.latitude);  
    longitude = double.tryParse(HomePage.longitude);  
    _center = LatLng(latitude ?? 0, longitude ?? 0);
    targetLatLng = LatLng(_center.latitude + offsetLat, _center.longitude);
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: targetLatLng,
            zoom: 15.0,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("Politeknik Negeri Jember"),
              position: _center,
              infoWindow: const InfoWindow(
                title: "Politeknik Negeri Jember",
                snippet: "Lokasi lahan sawwah A",
              ), // InfoWindow
            ), //Marker
          },
        ),
      ),
    );
  }

}
