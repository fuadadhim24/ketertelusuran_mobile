import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;

import 'package:ketertelusuran_mobile/ui/pages/tambah_lahan_page.dart';

class MapPicker extends StatefulWidget {
  static String? resultLatitude;
  static String? resultLongitude;
  static const kInitialPosition = LatLng(-8.15925416528586, 113.7231162153448);
  const MapPicker({super.key});

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  PickResult? selectedPlace;
  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey: Platform.isAndroid
          ? "AIzaSyB8zvxTXSOqJzhaxKMjZGMYuHp3g_eo48c"
          : "AIzaSyB8zvxTXSOqJzhaxKMjZGMYuHp3g_eo48c",
      onPlacePicked: (result) {
        selectedPlace = result;
        result.formattedAddress;
        TambahLahanPage.resultLatitude = selectedPlace!.geometry!.location.lat.toString();
        TambahLahanPage.resultLongitude = selectedPlace!.geometry!.location.lng.toString();
        Get.offNamed('/tambah-lahan');
      },
      initialPosition: MapPicker.kInitialPosition,
      useCurrentLocation: true,
      resizeToAvoidBottomInset:
          false, // only works in page mode, less flickery, remove if wrong offsets
    );
  }
}
