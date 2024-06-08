import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:ketertelusuran_mobile/shared/global.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';
import 'package:ketertelusuran_mobile/ui/widgets/home_service_item.dart';

class RiwayatProduksiPage extends StatefulWidget {
  const RiwayatProduksiPage({Key? key}) : super(key: key);

  @override
  _RiwayatProduksiPage createState() => _RiwayatProduksiPage();
}

class _RiwayatProduksiPage extends State<RiwayatProduksiPage> {
  TextEditingController _searchController = TextEditingController();
  bool isTanggalProduksi = true;
  bool search = false;
  int selectedOption = 0; // Default selected option is "Semua"
  final dio = Dio();
  List<dynamic> produksiList = [];
  List<dynamic> produksiSearchedList = [];

  void toggleSeason() {
    setState(() {
      isTanggalProduksi = !isTanggalProduksi;
      selectedOption = 0;
      // debugPrint(jsonEncode(produksiSearchedList));
      // debugPrint(jsonEncode(produksiList));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Riwayat Produksi',
          style: BlackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              buildNotes(),
              SizedBox(
                height: 5,
              ),
              isTanggalProduksi
                  ? buildSearchContainer()
                  : CustomDatePicker(title: 'Pilih tanggal produksi'),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: buildVarietasProduksiContent(context),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNotes() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteContainerColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pilih Berdasarkan Kriteria',
                  style: BlackTextStyle.copyWith(
                    fontSize: 25,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Pilih data produksi berdasarkan kriteria yang Anda inginkan.',
                  style: BlackTextStyle.copyWith(fontSize: 12),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: toggleSeason,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: MediaQuery.of(context).size.width / 2 -26,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isTanggalProduksi
                              ? greenColor
                              : whiteContainerColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.numbers,
                              color: isTanggalProduksi
                                  ? whiteContainerColor
                                  : txtBlackColor,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Kode Produksi',
                              style: TextStyle(
                                color: isTanggalProduksi
                                    ? whiteContainerColor
                                    : txtBlackColor,
                                fontWeight: semiBold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: toggleSeason,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          color: !isTanggalProduksi
                              ? greenColor
                              : whiteContainerColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: !isTanggalProduksi
                                  ? whiteContainerColor
                                  : txtBlackColor,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Tanggal Produksi',
                              style: TextStyle(
                                color: !isTanggalProduksi
                                    ? whiteContainerColor
                                    : txtBlackColor,
                                fontWeight: semiBold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchContainer() {
    return Container(
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: whiteContainerColor,
      ),
      child: Center(
        child: Column(
          children: [
            buildSearchAndFilter(),
          ],
        ),
      ),
    );
  }

  Widget buildSearchAndFilter() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: whiteBackgroundColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: txtBlackColor,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Cari Produksi',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  // debugPrint(jsonEncode(produksiList));
                  // debugPrint(jsonEncode(produksiList));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.filter_alt, color: whiteContainerColor),
                    onPressed: () {
                      searchProduksi();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildOption('Semua', isSelected: selectedOption == 0),
            buildOption('Req', isSelected: selectedOption == 1),
            buildOption('Selalu', isSelected: selectedOption == 2),
            buildOption('Jarang', isSelected: selectedOption == 3),
          ],
        ),
      ],
    );
  }

  Widget buildOption(String option, {bool isSelected = false}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedOption = ['Semua', 'Req', 'Selalu', 'Jarang'].indexOf(option);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 17),
        decoration: BoxDecoration(
          color: isSelected ? greenColor : Colors.transparent,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Text(
          option,
          style: TextStyle(
            color: isSelected ? whiteContainerColor : txtBlackColor,
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }

  Widget buildVarietasProduksiContent(BuildContext context) {
    return FutureBuilder(
      future: readProduksi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Tampilkan indikator loading saat menunggu data
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Tampilkan pesan error jika terjadi kesalahan
        } else {
          if (_searchController.text.isEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: produksiList
                  .length, // Gunakan panjang daftar produksi sebagai itemCount
              itemBuilder: (context, index) {
                return isTanggalProduksi
                    ? produksiList[index]['jenis_musim'] == 'Hujan' &&
                            (selectedOption == 0 ||
                                (selectedOption == 1 &&
                                    produksiList[index]['kategori'] ==
                                        'Rekomendasi') ||
                                (selectedOption == 2 &&
                                    produksiList[index]['kategori'] ==
                                        'Selalu') ||
                                (selectedOption == 3 &&
                                    produksiList[index]['kategori'] ==
                                        'Jarang'))
                        ? buildContentCard(
                            produksiList[index]['varietas'],
                            produksiList[index]['kategori'],
                            produksiList[index]['karakteristik_hasil'],
                          )
                        : SizedBox()
                    : produksiList[index]['jenis_musim'] == 'Kemarau' &&
                            (selectedOption == 0 ||
                                (selectedOption == 1 &&
                                    produksiList[index]['kategori'] ==
                                        'Rekomendasi') ||
                                (selectedOption == 2 &&
                                    produksiList[index]['kategori'] ==
                                        'Selalu') ||
                                (selectedOption == 3 &&
                                    produksiList[index]['kategori'] ==
                                        'Jarang'))
                        ? buildContentCard(
                            produksiList[index]['varietas'],
                            produksiList[index]['kategori'],
                            produksiList[index]['karakteristik_hasil'],
                          )
                        : SizedBox();
              },
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: produksiSearchedList
                  .length, // Gunakan panjang daftar produksi sebagai itemCount
              itemBuilder: (context, index) {
                return isTanggalProduksi
                    ? produksiSearchedList[index]['jenis_musim'] == 'Hujan' &&
                            (selectedOption == 0 ||
                                (selectedOption == 1 &&
                                    produksiSearchedList[index]['kategori'] ==
                                        'Rekomendasi') ||
                                (selectedOption == 2 &&
                                    produksiSearchedList[index]['kategori'] ==
                                        'Selalu') ||
                                (selectedOption == 3 &&
                                    produksiSearchedList[index]['kategori'] ==
                                        'Jarang'))
                        ? buildContentCard(
                            produksiSearchedList[index]['varietas'],
                            produksiSearchedList[index]['kategori'],
                            produksiSearchedList[index]['karakteristik_hasil'],
                          )
                        : SizedBox()
                    : produksiSearchedList[index]['jenis_musim'] == 'Kemarau' &&
                            (selectedOption == 0 ||
                                (selectedOption == 1 &&
                                    produksiSearchedList[index]['kategori'] ==
                                        'Rekomendasi') ||
                                (selectedOption == 2 &&
                                    produksiSearchedList[index]['kategori'] ==
                                        'Selalu') ||
                                (selectedOption == 3 &&
                                    produksiSearchedList[index]['kategori'] ==
                                        'Jarang'))
                        ? buildContentCard(
                            produksiSearchedList[index]['varietas'],
                            produksiSearchedList[index]['kategori'],
                            produksiSearchedList[index]['karakteristik_hasil'],
                          )
                        : SizedBox();
              },
            );
          }
        }
      },
    );
  }

  Widget buildContentCard(namaProduksi, kategori, karakteristikHasil) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: whiteContainerColor,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        namaProduksi,
                        style: TextStyle(
                          fontWeight: semiBold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        kategori, // Ganti dengan keterangan sesuai konten
                        style: BlackTextStyle.copyWith(
                          fontSize: 11,
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          karakteristikHasil, // Ganti dengan informasi sesuai konten
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: BlackTextStyle.copyWith(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Get.toNamed(
                              '/detail-produksi'); // Tambahkan aksi ketika tombol "Baca Selengkapnya" ditekan
                        },
                        child: Row(
                          children: [
                            Text(
                              'Detail Produksi',
                              style: TextStyle(
                                color: greenColor,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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

  Future<void> readProduksi() async {
    if (produksiList.isEmpty) {
      final url = Global.serverUrl + Global.produksiPath + Global.readProduksiPath;
      final finalUrl = url;
      Response response;
      response = await dio.get(finalUrl);
      final body = response.data;
      var stringResponse = body.toString();
      var responseData = stringResponse.replaceAll('{', '').replaceAll('}', '');
      if (response.statusCode == 200) {
        if (body.containsKey('data')) {
          // _showSuccessSnackBar(context,'Berhasil Mendapatkan Data Lahan');
          produksiList = body['data'];
          // debugPrint(jsonEncode(body));
          // debugPrint('lahanList : $lahanList');
        } else {
          _showWarningSnackBar(context, responseData);
        }
      } else {
        _showWarningSnackBar(context, responseData);
      }
    }
  }

  void searchProduksi() {
    // Mendapatkan teks yang dimasukkan pengguna pada TextField
    String searchText = _searchController.text.toLowerCase();

    // Menerapkan filter pada daftar produksi berdasarkan teks pencarian
    List<dynamic> filteredList = produksiList.where((produksi) {
      String namaVarietas = produksi['varietas'].toLowerCase();

      // Return true jika nama produksi atau kategori mengandung teks pencarian
      return namaVarietas.contains(searchText);
    }).toList();
    // debugPrint('cek 10');
    setState(() {
      produksiSearchedList = filteredList;
    });
  }
}
