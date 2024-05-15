import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:ketertelusuran_mobile/shared/global.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/widgets/home_service_item.dart';

class VarietasPadiPage extends StatefulWidget {
  const VarietasPadiPage({Key? key}) : super(key: key);

  @override
  _VarietasPadiPageState createState() => _VarietasPadiPageState();
}

class _VarietasPadiPageState extends State<VarietasPadiPage> {
  TextEditingController _searchController = TextEditingController();
  bool isRainySeason = true; // Default is rainy season
  bool search = false;
  int selectedOption = 0; // Default selected option is "Semua"
  final dio = Dio();
  List<dynamic> padiList = [];
  List<dynamic> padiSearchedList = [];

  void toggleSeason() {
    setState(() {
      isRainySeason = !isRainySeason;
      selectedOption = 0;
      debugPrint(jsonEncode(padiSearchedList));
      // debugPrint(jsonEncode(padiList));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Varietas Padi',
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
              buildSearchContainer(),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: buildVarietasPadiContent(context),
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

  Widget buildHomeHeading() {
    return Container(
      margin: const EdgeInsets.only(
        top: 64,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/ic_back.png'),
                  ),
                ),
              ),
              Text(
                'Varietas Padi',
                textAlign: TextAlign.center,
                style: BlackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              Container(
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/ic_notification.png',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildNotes() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteContainerColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Musim Apa yang Sedang Berlangsung?',
                  style: BlackTextStyle.copyWith(
                    fontSize: 25,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Pilih jenis benih varietas padi sesuai musim di daerah anda pada 4 bulan kedepan.',
                  style: BlackTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: toggleSeason,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          color:
                              isRainySeason ? greenColor : whiteContainerColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.water_drop,
                              color: isRainySeason
                                  ? whiteContainerColor
                                  : txtBlackColor,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Musim Hujan',
                              style: TextStyle(
                                color: isRainySeason
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
                          color:
                              !isRainySeason ? greenColor : whiteContainerColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud,
                              color: !isRainySeason
                                  ? whiteContainerColor
                                  : txtBlackColor,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Musim Kemarau',
                              style: TextStyle(
                                color: !isRainySeason
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
                          hintText: 'Cari Varietas Padi',
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
                  // debugPrint(jsonEncode(padiList));
                  // debugPrint(jsonEncode(padiList));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.filter_alt, color: whiteContainerColor),
                    onPressed: () {
                      searchPadi();
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

  Widget buildVarietasPadiContent(BuildContext context) {
    return FutureBuilder(
      future: readPadi(),
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
              itemCount: padiList
                  .length, // Gunakan panjang daftar padi sebagai itemCount
              itemBuilder: (context, index) {
                return isRainySeason
                    ? padiList[index]['jenis_musim'] == 'Hujan' &&
                            (selectedOption == 0 ||
                                (selectedOption == 1 &&
                                    padiList[index]['kategori'] ==
                                        'Rekomendasi') ||
                                (selectedOption == 2 &&
                                    padiList[index]['kategori'] == 'Selalu') ||
                                (selectedOption == 3 &&
                                    padiList[index]['kategori'] == 'Jarang'))
                        ? buildContentCard(
                            padiList[index]['varietas'],
                            padiList[index]['kategori'],
                            padiList[index]['karakteristik_hasil'],
                          )
                        : SizedBox()
                    : padiList[index]['jenis_musim'] == 'Kemarau' &&
                            (selectedOption == 0 ||
                                (selectedOption == 1 &&
                                    padiList[index]['kategori'] ==
                                        'Rekomendasi') ||
                                (selectedOption == 2 &&
                                    padiList[index]['kategori'] == 'Selalu') ||
                                (selectedOption == 3 &&
                                    padiList[index]['kategori'] == 'Jarang'))
                        ? buildContentCard(
                            padiList[index]['varietas'],
                            padiList[index]['kategori'],
                            padiList[index]['karakteristik_hasil'],
                          )
                        : SizedBox();
              },
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: padiSearchedList
                  .length, // Gunakan panjang daftar padi sebagai itemCount
              itemBuilder: (context, index) {
                return isRainySeason
                    ? padiSearchedList[index]['jenis_musim'] == 'Hujan' &&
                            (selectedOption == 0 ||
                                (selectedOption == 1 &&
                                    padiSearchedList[index]['kategori'] ==
                                        'Rekomendasi') ||
                                (selectedOption == 2 &&
                                    padiSearchedList[index]['kategori'] ==
                                        'Selalu') ||
                                (selectedOption == 3 &&
                                    padiSearchedList[index]['kategori'] ==
                                        'Jarang'))
                        ? buildContentCard(
                            padiSearchedList[index]['varietas'],
                            padiSearchedList[index]['kategori'],
                            padiSearchedList[index]['karakteristik_hasil'],
                          )
                        : SizedBox()
                    : padiSearchedList[index]['jenis_musim'] == 'Kemarau' &&
                            (selectedOption == 0 ||
                                (selectedOption == 1 &&
                                    padiSearchedList[index]['kategori'] ==
                                        'Rekomendasi') ||
                                (selectedOption == 2 &&
                                    padiSearchedList[index]['kategori'] ==
                                        'Selalu') ||
                                (selectedOption == 3 &&
                                    padiSearchedList[index]['kategori'] ==
                                        'Jarang'))
                        ? buildContentCard(
                            padiSearchedList[index]['varietas'],
                            padiSearchedList[index]['kategori'],
                            padiSearchedList[index]['karakteristik_hasil'],
                          )
                        : SizedBox();
              },
            );
          }
        }
      },
    );
  }

  Widget buildContentCard(namaPadi, kategori, karakteristikHasil) {
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
                        namaPadi,
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
                              '/read-more'); // Tambahkan aksi ketika tombol "Baca Selengkapnya" ditekan
                        },
                        child: Row(
                          children: [
                            Text(
                              'Baca Selengkapnya',
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

  Future<void> readPadi() async {
    if (padiList.isEmpty) {
      final url = Global.serverUrl + Global.readPadiPath;
      final finalUrl = url;
      Response response;
      response = await dio.get(finalUrl);
      final body = response.data;
      var stringResponse = body.toString();
      var responseData = stringResponse.replaceAll('{', '').replaceAll('}', '');
      if (response.statusCode == 200) {
        if (body.containsKey('data')) {
          // _showSuccessSnackBar(context,'Berhasil Mendapatkan Data Lahan');
          padiList = body['data'];
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

  void searchPadi() {
    // Mendapatkan teks yang dimasukkan pengguna pada TextField
    String searchText = _searchController.text.toLowerCase();

    // Menerapkan filter pada daftar padi berdasarkan teks pencarian
    List<dynamic> filteredList = padiList.where((padi) {
      String namaVarietas = padi['varietas'].toLowerCase();

      // Return true jika nama padi atau kategori mengandung teks pencarian
      return namaVarietas.contains(searchText);
    }).toList();
    debugPrint('cek 10');
    setState(() {
      padiSearchedList = filteredList;
    });
  }
}
