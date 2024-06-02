import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/global.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';
import 'package:ketertelusuran_mobile/ui/widgets/map.dart';
import 'package:ketertelusuran_mobile/ui/widgets/mapPicker.dart';
import 'package:ketertelusuran_mobile/ui/widgets/searchContainer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:dio/dio.dart' as dioP;
import 'dart:convert';

class TambahLahanPage extends StatefulWidget {
  static String? resultLatitude;
  static String? resultLongitude;
  const TambahLahanPage({super.key});

  @override
  State<TambahLahanPage> createState() => _TambahLahanPage();
}

class _TambahLahanPage extends State<TambahLahanPage> {
  final dio = dioP.Dio();
  TextEditingController _lahanController = TextEditingController();
  TextEditingController _detailLokasiController = TextEditingController();
  TextEditingController _luasController = TextEditingController();
  TextEditingController _jenisTanahController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // readLahan();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Tambah Lahan',
          style: BlackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeadingKetertelusuran(),
              SizedBox(height: 18),
              buildInputLahan(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeadingKetertelusuran() {
    return Container(
      padding: const EdgeInsets.only(
        top: 17,
        bottom: 5,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 21,
                    ),
                    Text(
                      'Pilih Lokasi Lahan',
                      style: BlackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Tekan pada map untuk menentukan titik lokasi',
                      style: BlackTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }

  Widget buildMapPanel() {
    return Container(
      child: MapPicker(),
    );
  }

  Widget buildInputLahan() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: Column(
        children: [
          CustomTextButton(
            title: TambahLahanPage.resultLatitude != null
                ? 'Ganti Titik Lokasi Lahan'
                : 'Tentukan Titik Lokasi Lahan',
            onPressed: () => Get.toNamed('/pilih-titik-lokasi-lahan'),
            color: true,
          ),
          const SizedBox(
            height: 36,
          ),
          CustomFormField(
            title: 'Nama Lahan',
            typeFormField: 0,
            controller: _lahanController,
          ),
          const SizedBox(
            height: 36,
          ),
          CustomFormField(
            title: 'Detail Lokasi',
            typeFormField: 0,
            controller: _detailLokasiController,
          ),
          const SizedBox(
            height: 36,
          ),
          CustomFormField(
            title: 'Luas',
            typeFormField: 0,
            controller: _luasController,
          ),
          const SizedBox(
            height: 36,
          ),
          CustomFormField(
            title: 'Jenis Tanah',
            typeFormField: 0,
            controller: _jenisTanahController,
          ),
          const SizedBox(
            height: 36,
          ),
          CustomFilledButton(
            title: 'Submit',
            onPressed: () {
              String? latitude = TambahLahanPage.resultLatitude;
              String? longitude = TambahLahanPage.resultLongitude;

              if (latitude == null || longitude == null) {
                _showWarningSnackBar(
                    context, 'Silakan tentukan titik lokasi lahan');
              } else if (_lahanController.text.isEmpty) {
                _showWarningSnackBar(context, 'Nama Lahan tidak boleh kosong');
              } else if (_detailLokasiController.text.isEmpty) {
                _showWarningSnackBar(
                    context, 'Detail Lokasi tidak boleh kosong');
              } else if (_luasController.text.isEmpty) {
                _showWarningSnackBar(context, 'Luas tidak boleh kosong');
              } else if (_jenisTanahController.text.isEmpty) {
                _showWarningSnackBar(context, 'Jenis Tanah tidak boleh kosong');
              } else {
                String namaLahan = _lahanController.text.toString();
                String detailLokasi = _detailLokasiController.text.toString();
                String luas = _luasController.text.toString();
                String jenisTanah = _jenisTanahController.text.toString();
                String status = 'Tersedia';
                // debugPrint(TambahLahanPage.resultLatitude);
                // debugPrint(TambahLahanPage.resultLongitude);
                // debugPrint(_lahanController.text.toString()
                //     // _detailLokasiController.text.toString()+
                //     // _luasController.text.toString()+
                //     // _jenisTanahController.text.toString()
                //     );
                // debugPrint(_detailLokasiController.text.toString());
                // debugPrint(_luasController.text.toString());
                // debugPrint(_jenisTanahController.text.toString());
                createLahan(latitude, longitude, namaLahan, detailLokasi, luas,
                    jenisTanah, status);
              }
              ;
            },
          ),
        ],
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Durasi notifikasi
      backgroundColor: greenColor, // Warna latar belakang notifikasi
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Jari-jari border radius
      ),
      behavior: SnackBarBehavior.floating, // Snackbar akan mengambang
      margin: EdgeInsets.symmetric(
          vertical: 20, horizontal: 60), // Menerapkan margin
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar); // Menampilkan notifikasi
  }

  // Fungsi untuk menampilkan notifikasi snack bar peringatan jika alamat email atau password kosong
  void _showWarningSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Durasi notifikasi
      backgroundColor: Colors.red, // Warna latar belakang notifikasi
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Jari-jari border radius
      ),
      behavior: SnackBarBehavior.floating, // Snackbar akan mengambang
      margin: EdgeInsets.symmetric(
          vertical: 20, horizontal: 60), // Menerapkan margin
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar); // Menampilkan notifikasi
  }

  void createLahan(latitude, longitude, namaLahan, detailLokasi, luas,
      jenisTanah, status) async {
    final url = Global.serverUrl + Global.createLahanPath;
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'nama_lahan': namaLahan,
      'detail_lokasi': detailLokasi,
      'luas': luas,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
    };
    try {
      final response = await dioP.Dio().post(
        url,
        data: jsonEncode(data),
        options: dioP.Options(headers: headers),
      );
      // debugPrint(jsonEncode(data));

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData.containsKey('success')) {
          _showSuccessSnackBar(context, 'Lahan berhasil ditambahkan!');
          Get.offAllNamed('/home');
        } else {
          _showWarningSnackBar(context, responseData);
        }
      } else {
        _showWarningSnackBar(context, 'Gagal menambahkan lahan');
      }
    } catch (e) {
      _showWarningSnackBar(context, 'Error $e');
    }
  }

}
