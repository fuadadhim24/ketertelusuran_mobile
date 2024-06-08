import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:ketertelusuran_mobile/services/produksi.dart';
import 'package:ketertelusuran_mobile/services/validator.dart';
import 'package:ketertelusuran_mobile/shared/global.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';
import 'package:ketertelusuran_mobile/ui/widgets/dropDownForm.dart';

class PanenPage extends StatefulWidget {
  PanenPage({super.key});

  @override
  State<PanenPage> createState() => _PanenPageState();
}

class _PanenPageState extends State<PanenPage> {
  TextEditingController quantityController = TextEditingController();
  TextEditingController metodePanenController = TextEditingController();
  TextEditingController catatanController = TextEditingController();
  String? resultDatePanen;
  String? idProduksi = Produksi.produksiNonPanenChoosedList['id'].toString();

  String? idPadi = Produksi.produksiNonPanenChoosedList['id_padi'].toString();
  String? namaPadi;

  List<dynamic> padiList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Panen',
          style: BlackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: readPadi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              children: [
                buildFormContent(context),
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildFormContent(context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 36,
      ),
      width: double.infinity,
      height: 739,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 50,
            child: Container(
              width: MediaQuery.of(context).size.width - 14,
              height: MediaQuery.of(context).size.height - 50,
              decoration: BoxDecoration(
                color: whiteContainerColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  buildHeadingContent(),
                  buildMainContent(context),
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(
              width: 111,
              height: 101,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: whiteContainerColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: whiteContainerColor,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    width: 1,
                    color: greenColor,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/ic_grade.png',
                      height: 42,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeadingContent() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 120,
            height: 24,
            decoration: BoxDecoration(
              color: greenColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ic_grade_varietas.png',
                  width: 12,
                  height: 12,
                ),
                const SizedBox(
                  width: 9,
                ),
                Text(
                  namaPadi!,
                  style: WhiteTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 24,
            decoration: BoxDecoration(
              color: greenColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ic_time.png',
                  width: 12,
                  height: 12,
                ),
                const SizedBox(
                  width: 9,
                ),
                Text(
                  Produksi.currentDays != 0
                      ? 'Hari ke -' + Produksi.currentDays.toString()
                      : '__',
                  style: WhiteTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMainContent(context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            'Data ketertelusuran',
            style: BlackTextStyle.copyWith(
              fontSize: 10,
              fontWeight: semiBold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            HomePage.namaLahan,
            style: BlackTextStyle.copyWith(
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 36,
          ),
          CustomFormField(
            title: 'Jumlah Panen',
            typeFormField: 0,
            controller: quantityController,
            textInputType: TextInputType.number,
          ),
          const SizedBox(
            height: 36,
          ),
          CustomFormField(
            title: 'Metode Panen',
            typeFormField: 0,
            controller: metodePanenController,
          ),
          const SizedBox(
            height: 36,
          ),
          CustomFormField(
            title: 'Catatan',
            typeFormField: 0,
            controller: catatanController,
          ),
          const SizedBox(
            height: 36,
          ),
          CustomDatePicker(
            title: 'Tanggal Panen',
            onDatePicked: (date) {
              resultDatePanen = date;
            },
          ),
          const SizedBox(
            height: 18,
          ),
          CustomFilledButton(
            title: 'Submit',
            onPressed: () {
              String quantity = quantityController.text;
              String metodePanen = metodePanenController.text;
              String catatan = catatanController.text;

              if (Validator.validateInt(quantity)) {
                if (Validator.validateString(metodePanen)) {
                  if (Validator.validateString(catatan)) {
                    if (resultDatePanen != null) {
                      createPanen(quantity, metodePanen, catatan, idProduksi,
                          resultDatePanen);
                    } else {
                      _showWarningSnackBar(
                          context, 'Silakan pilih tanggal panen');
                    }
                  } else {
                    _showWarningSnackBar(context, 'Silakan isi catatan');
                  }
                } else {
                  _showWarningSnackBar(context, 'Silakan isi metode panen');
                }
              } else {
                _showWarningSnackBar(context, 'Silakan isi jumlah panen');
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> readPadi() async {
    if (padiList.isEmpty) {
      final url = Global.serverUrl + Global.readPadiPath;
      final finalUrl = url;
      Response response;
      response = await Dio().get(finalUrl);
      final body = response.data;
      var stringResponse = body.toString();
      var responseData = stringResponse.replaceAll('{', '').replaceAll('}', '');
      if (response.statusCode == 200) {
        if (body.containsKey('data')) {
          // _showSuccessSnackBar(context,'Berhasil Mendapatkan Data Lahan');
          padiList = body['data'];
          choosedPadi();
        } else {
          _showWarningSnackBar(context, responseData);
        }
      } else {
        _showWarningSnackBar(context, responseData);
      }
    } else {
      choosedPadi();
    }
  }

  void choosedPadi() {
    var choosedPadi = padiList.firstWhere(
        (padi) => padi['id'].toString() == idPadi,
        orElse: () => null);

    // Jika padi dengan idPadiSearch ditemukan, set variabel namaPadi
    if (choosedPadi != null) {
      namaPadi = choosedPadi['varietas'].toString();
    } else {
      // Jika tidak ditemukan, set namaPadi ke null atau string kosong, sesuai kebutuhan aplikasi Anda
      namaPadi = 'Anda belum menentukan penyemaian'; // atau namaPadi = '';
    }
    // debugPrint(choosedPadi.toString());
    // debugPrint(idPadi.toString());
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

  void createPanen(
      quantity, metodePanen, catatan, idProduksi, tanggalPanen) async {
    final url = Global.serverUrl + Global.panenPath;
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'quantity': quantity,
      'metode_panen': metodePanen,
      'catatan': catatan,
      'id_produksi': idProduksi,
      'tanggal_panen': tanggalPanen
    };

    try {
      final response = await Dio().post(
        url,
        data: jsonEncode(data),
        options: Options(headers: headers),
      );
      // debugPrint(jsonEncode(data));

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData.containsKey('success')) {
          _showSuccessSnackBar(context, 'Panen berhasil ditambahkan!');
          Get.offNamed('/home');
        } else {
          _showWarningSnackBar(context, responseData);
        }
      } else {
        _showWarningSnackBar(context, 'Gagal menambahkan data panen');
      }
    } catch (e) {
      _showWarningSnackBar(context, 'Error $e');
    }
  }
}
