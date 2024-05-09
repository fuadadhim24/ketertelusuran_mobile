import 'package:flutter/material.dart';
import 'package:ketertelusuran_mobile/ui/widgets/mapPicker.dart';

class PilihLokasiPage extends StatefulWidget {
  const PilihLokasiPage({Key? key}) : super(key: key);

  @override
  State<PilihLokasiPage> createState() => _PilihLokasiPageState();
}

class _PilihLokasiPageState extends State<PilihLokasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Titik Lokasi Lahan'),
      ),
      body: MapPicker(), // Panggil MapPicker di sini
    );
  }
}
