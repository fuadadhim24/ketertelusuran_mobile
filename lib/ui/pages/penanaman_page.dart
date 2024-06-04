import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:ketertelusuran_mobile/services/produksi.dart';
import 'package:ketertelusuran_mobile/services/validator.dart';
import 'package:ketertelusuran_mobile/shared/global.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/sign_in_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/varietas_padi_page.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';
import 'package:ketertelusuran_mobile/ui/widgets/dropDownForm.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';
import 'package:ketertelusuran_mobile/ui/widgets/map.dart';

class PenanamanPage extends StatefulWidget {
  const PenanamanPage({super.key});

  @override
  State<PenanamanPage> createState() => _PenanamanPageState();
}

class _PenanamanPageState extends State<PenanamanPage> {
  String? selectedLahan;
  String? resultDatePenanaman;
  String? idProduksi = Produksi.produksiNonPanenChoosedList['id'].toString();
  List<dynamic> padiList = [];
  String? idPadi = Produksi.produksiNonPanenChoosedList['id_padi'].toString();
  String? namaPadi;
  List<dynamic> lahanList =
      HomePage.lahanList; // Ini adalah inisialisasi variabel lahanList
  List<dynamic> produksiList = HomePage.produksiList;
  List<String> lahanUnUsed = [];
  List<String> lahanUsed = [];
  List<String> itemsLahan = []; // Inisialisasi itemsLahan sebagai list kosong

  void convertLahanList() {
    produksiList.forEach((element) {
      // Mengambil nilai id_lahan dari element
      var idLahan = element['id_lahan'];
      var lahan = lahanList.firstWhere(
        (lahan) => lahan['id'] == idLahan,
        orElse: () => null,
      );

      // Jika lahan ditemukan, tambahkan nama_lahan ke lahanUnUsed
      if (lahan != null) {
        lahanUsed.add(lahan['nama_lahan'].toString());
      }
    });
    // debugPrint('lahanUsed: $lahanUsed');
    for (var lahan in lahanList) {
      // Mengambil nama lahan dari masing-masing data lahan
      var nama_lahan = lahan["nama_lahan"];

      // Memeriksa apakah nama lahan tidak ada dalam LahanUsed
      if (!lahanUsed.contains(nama_lahan)) {
        // Menambahkan nama lahan ke LahanUnUsed
        lahanUnUsed.add(nama_lahan);
      }
    }
    // debugPrint('lahanUnUsed: $lahanUnUsed');

    itemsLahan = lahanUnUsed.toList();
  }

  @override
  void initState() {
    super.initState();
    readPadi();
    convertLahanList();
  }

  bool changeLahan = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Penanaman',
          style: BlackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
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
                buildMainForm(),
              ],
            );
          }
        },
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
            title: 'Benih Varietas Padi', stringInitialValue: namaPadi),
        SizedBox(
          height: 36,
        ),
        CustomDatePicker(
          title: 'Tanggal Penanaman',
          onDatePicked: (date) {
            resultDatePenanaman = date;
          },
        ),
        SizedBox(
          height: 36,
        ),
        changeLahan == false
            ? CustomTextButton(
                title: 'Apakah anda ingin mengganti lahan?',
                onPressed: () {
                  setState(() {
                    changeLahan = true;
                  });
                },
              )
            : CustomTextButton(
                title: 'Batal ganti lahan',
                onPressed: () {
                  setState(() {
                    changeLahan = false;
                  });
                },
              ),
        SizedBox(
          height: 36,
        ),
        changeLahan != false
            ? CustomDropDownFormField(
                initialValue: 'Lahan saat ini: ' + HomePage.namaLahan,
                items: itemsLahan,
                onValueChanged: (value) => {selectedLahan = value},
              )
            : SizedBox(
                height: 36,
              ),
        SizedBox(
          height: 48,
        ),
        CustomFilledButton(
          title: 'Tanam',
          onPressed: () {
            if (changeLahan != true) {
              if (resultDatePenanaman != null) {
                createPenanaman(idProduksi, resultDatePenanaman);
              } else {
                _showWarningSnackBar(
                    context, 'Silakan pilih tanggal penanaman');
              }
            } else {
              // Mencari data berdasarkan nama_lahan
              var hasilPencarian = lahanList
                  .where((lahan) => lahan["nama_lahan"] == selectedLahan);

              // Mendapatkan id dari hasil pencarian
              var idLahan =
                  hasilPencarian.isNotEmpty ? hasilPencarian.first["id"] : null;
              // debugPrint(selectedLahan);
              // debugPrint(lahanList.toString());
              if (resultDatePenanaman != null) {
                if (idLahan != null) {
                  createPenanamanChangeLahan(
                      idProduksi, resultDatePenanaman, idLahan);
                } else {
                  _showWarningSnackBar(
                      context, 'Pilih lahan yang ingin diganti');
                }
              } else {
                _showWarningSnackBar(
                    context, 'Silakan pilih tanggal penanaman');
              }
            }
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

  void createPenanaman(idProduksi, tanggalPenanaman) async {
    final url = Global.serverUrl + Global.penanamanPath;
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'id_produksi': idProduksi,
      'tanggal_penanaman': tanggalPenanaman,
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
        debugPrint(responseData.toString());
        if (responseData.containsKey('success')) {
          _showSuccessSnackBar(context, 'Penanaman berhasil ditambahkan!');
          Get.offNamed('/home');
        } else {
          _showWarningSnackBar(context, responseData);
        }
      } else {
        _showWarningSnackBar(context, 'Gagal menambahkan data penanaman');
      }
    } catch (e) {
      _showWarningSnackBar(context, 'Error $e');
    }
    void populateItemsFromLahanList() {
      itemsLahan = HomePage.lahanList.map<String>((lahan) {
        // Ambil nama lahan dari objek lahan dan tambahkan ke dalam list
        return lahan['nama_lahan'];
      }).toList();
    }
  }

  void createPenanamanChangeLahan(idProduksi, tanggalPenanaman, idLahan) async {
    final url = Global.serverUrl + Global.penanamanPath;
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'id_produksi': idProduksi,
      'tanggal_penanaman': tanggalPenanaman,
      'id_lahan': idLahan,
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
          _showSuccessSnackBar(context, 'Penanaman berhasil ditambahkan!');
          Get.offNamed('/home');
        } else {
          _showWarningSnackBar(context, responseData);
        }
      } else {
        _showWarningSnackBar(context, 'Gagal menambahkan data penanaman');
      }
    } catch (e) {
      _showWarningSnackBar(context, 'Error $e');
    }
    void populateItemsFromLahanList() {
      itemsLahan = HomePage.lahanList.map<String>((lahan) {
        // Ambil nama lahan dari objek lahan dan tambahkan ke dalam list
        return lahan['nama_lahan'];
      }).toList();
    }
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
          // debugPrint('produksiList : $produksiList');
          // debugPrint('lahanList : $lahanList');
          // debugPrint(padiList.toString());
          // debugPrint(Produksi.produksiNonPanenChoosedList.toString());
          choosedPadi();
          // debugPrint(jsonEncode(body));
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
}
