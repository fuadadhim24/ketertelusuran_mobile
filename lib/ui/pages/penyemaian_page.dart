import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/services/validator.dart';
import 'package:ketertelusuran_mobile/shared/global.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/penanaman_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_in_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/varietas_padi_page.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';
import 'package:ketertelusuran_mobile/ui/widgets/map.dart';

class PenyemaianPage extends StatefulWidget {
  static String? resultDateKedaluwarsa;
  static String? resultDatePenyemaian;
  static String varietasPadi = '';
  const PenyemaianPage({super.key});

  @override
  State<PenyemaianPage> createState() => _PenyemaianPageState();
}

class _PenyemaianPageState extends State<PenyemaianPage> {
  TextEditingController sumberBenihController = TextEditingController();
  TextEditingController tingkatKemurnianController = TextEditingController();
  TextEditingController tingkatVigorController = TextEditingController();
  TextEditingController jumlahBenihController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Penyemaian',
          style: BlackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        children: [
          buildMainForm(),
        ],
      ),
    );
  }

  Widget buildMainForm() {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        CustomStringFormField(
                title: 'Benih Varietas Padi', stringInitialValue: VarietasPadiPage.varietas),
        SizedBox(
          height: 36,
        ),
        CustomFormField(
          title: 'Sumber Benih',
          typeFormField: 0,
          controller: sumberBenihController,
        ),
        SizedBox(
          height: 36,
        ),
        CustomDatePicker(
          title: 'Tanggal Kedaluwarsa Benih',
          onDatePicked: (date) {
            PenyemaianPage.resultDateKedaluwarsa = date;
          },
        ),
        SizedBox(
          height: 36,
        ),
        CustomFormField(
          title: 'Tingkat Kemurnian (%)',
          typeFormField: 0,
          controller: tingkatKemurnianController,
        ),
        SizedBox(
          height: 36,
        ),
        CustomFormField(
          title: 'Tingkat Vigor (%)',
          typeFormField: 0,
          controller: tingkatVigorController,
        ),
        SizedBox(
          height: 36,
        ),
        CustomDatePicker(
          title: 'Tanggal Penyemaian',
          onDatePicked: (date) {
            PenyemaianPage.resultDatePenyemaian = date;
          },
        ),
        SizedBox(
          height: 36,
        ),
        CustomFormField(
          title: 'Jumlah Benih',
          typeFormField: 0,
          controller: jumlahBenihController,
        ),
        SizedBox(
          height: 48,
        ),
        CustomFilledButton(
          title: 'Buat Produksi',
          onPressed: () {
            // Get.offAllNamed('/home');
            String sumberBenih = sumberBenihController.text.toString();
            String tingkatKemurnian =
                tingkatKemurnianController.text.toString();
            String tingkatVigor = tingkatVigorController.text.toString();
            String? resultTanggalKedaluwarsa =
                PenyemaianPage.resultDateKedaluwarsa;
            String? resultTanggalPenyemaian =
                PenyemaianPage.resultDatePenyemaian;
            String jumlahBenih = jumlahBenihController.text.toString();
            String? idPadi = VarietasPadiPage.id;
            String? idLahan = HomePage.idLahan;
            String? idUser = SignInPage.idUser;
            if (resultTanggalKedaluwarsa != null) {
              if (resultTanggalPenyemaian != null) {
                if (Validator.validateString(sumberBenih) &&
                    Validator.validateInt(tingkatKemurnian) &&
                    Validator.validateInt(tingkatVigor) &&
                    Validator.validateInt(jumlahBenih)) {
                  createPenyemaian(
                      sumberBenih,
                      resultTanggalKedaluwarsa,
                      tingkatKemurnian,
                      tingkatVigor,
                      resultTanggalPenyemaian,
                      jumlahBenih,
                      idPadi,
                      idLahan,
                      idUser);
                }else{
                  _showWarningSnackBar(context, 'Silakan isi semua data pada form yang disediakan');
                }
              } else {
                _showWarningSnackBar(
                    context, 'Silakan pilih tanggal penyemaian');
              }
            } else {
              _showWarningSnackBar(
                  context, 'Silakan pilih tanggal kedaluwarsa benih');
            }
            // debugPrint(
            //     '$sumberBenih, $result, $tingkatKemurnian, $tingkatVigor');
          },
        ),
      ],
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

  void createPenyemaian(
      sumberBenih,
      tanggalKedaluwarsa,
      tingkatKemurnian,
      tingkatVigor,
      tanggalPenyemaian,
      jumlahBenih,
      idPadi,
      idLahan,
      idUser) async {
    final url = Global.serverUrl + Global.produksiPath + Global.penyemaianPath;
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'sumber_benih': sumberBenih,
      'tanggal_kedaluwarsa': tanggalKedaluwarsa,
      'tingkat_kemurnian': tingkatKemurnian,
      'tingkat_vigor': tingkatVigor,
      'tanggal_penyemaian': tanggalPenyemaian,
      'jumlah_benih': jumlahBenih,
      'id_padi': idPadi,
      'id_lahan': idLahan,
      'id_user': idUser,
    };

    try {
      final response = await Dio().post(
        url,
        data: jsonEncode(data),
        options: Options(headers: headers),
      );
      debugPrint(jsonEncode(data));

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData.containsKey('success')) {
          _showSuccessSnackBar(context, 'Penyemaian berhasil ditambahkan!');
          Get.offNamed('/home');
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
