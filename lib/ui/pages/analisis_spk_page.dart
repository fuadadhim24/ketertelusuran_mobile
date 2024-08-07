import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:ketertelusuran_mobile/services/fase.dart';
import 'package:ketertelusuran_mobile/services/produksi.dart';
import 'package:ketertelusuran_mobile/shared/global.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/widgets/forms.dart';
import 'package:ketertelusuran_mobile/ui/widgets/map.dart';
import 'package:ketertelusuran_mobile/ui/widgets/searchContainer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:ketertelusuran_mobile/ui/pages/analisis_spk_page.dart';

class AnalisisSpkPage extends StatefulWidget {
  static String id = '';
  static String nama = '';
  static String deskripsi = '';
  static String penanggulangan = '';
  static String gambarPath = '';
  static String createdAt = '';
  const AnalisisSpkPage({super.key});

  @override
  State<AnalisisSpkPage> createState() => _AnalisisSpkPageState();
}

class _AnalisisSpkPageState extends State<AnalisisSpkPage> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> hamaDanPenyakitList = [];
  List<dynamic> hamaDanPenyakitChoosedList = [];
  List<dynamic> hamaDanPenyakitSearchedList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Analisis SPK',
          style: BlackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        ),
      ),
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height / 3,
        maxHeight: MediaQuery.of(context).size.height,
        panel: Container(
          child: Column(
            children: [
              buildHeadingKetertelusuran(),
              buildPerlakuan(),
              SizedBox(
                height: 18,
              ),
              Text(
                'Hama dan Penyakit',
                style: redTextStyle.copyWith(
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  children: [
                    buildContent(),
                    buildHamaDanPenyakitContent(),
                    const SizedBox(
                      height: 150,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: buildMapPanel(),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 21,
                    ),
                    Text(
                      'Manajemen Sawah Anda',
                      style: BlackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Sistem Pendukung Keputusan',
                      style: BlackTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 94,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: whiteBackgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 13,
                      height: 13,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/ic_fire.png'),
                        ),
                      ),
                    ),
                    Text(
                      'Berlangsung',
                      style: BlackTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: semiBold,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      right: 5,
                    ),
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/ic_fase.png',
                        ),
                      ),
                    ),
                  ),
                  Text(
                    Fase.namaFase != "" ? ('Fase ' + Fase.namaFase) : '__',
                    style: BlackTextStyle.copyWith(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      right: 5,
                    ),
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/ic_date.png',
                        ),
                      ),
                    ),
                  ),
                  Text(
                    Produksi.currentDays != 0
                        ? 'Hari ke -' + Produksi.currentDays.toString()
                        : '__',
                    style: BlackTextStyle.copyWith(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPerlakuan() {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      height: 120,
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
      ),
      color: greenColor,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pengingat',
                      style: WhiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Sistem Pendukung Keputusan',
                      style: WhiteTextStyle.copyWith(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Container(
                  width: 96,
                  height: 22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: whiteContainerColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Rekomendasi',
                        style: BlackTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: whiteContainerColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '- ',
                      style: WhiteTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      Fase.namaPerlakuan != "" ? (Fase.namaPerlakuan) : '__',
                      style: WhiteTextStyle.copyWith(
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeadingFilter() {
    return Container(
      color: whiteBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 16,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/ic_double_down.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContent() {
    return Container(
      color: whiteBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          buildHeadingFilter(),
          buildSearchContainer(),
        ],
      ),
    );
  }

  Widget buildHamaDanPenyakitContent() {
    return FutureBuilder(
      future: readHamaDanPenyakit(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (searchController.text.isEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hamaDanPenyakitList.length,
              itemBuilder: (context, index) {
                return buildContentCard(
                  hamaDanPenyakitList[index]['id'] ?? '',
                  hamaDanPenyakitList[index]['gambar_path'] ?? '',
                  hamaDanPenyakitList[index]['nama'] ?? '',
                  hamaDanPenyakitList[index]['deskripsi'] ?? '',
                );
              },
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hamaDanPenyakitSearchedList.length,
              itemBuilder: (context, index) {
                return buildContentCard(
                  hamaDanPenyakitSearchedList[index]['id'] ?? '',
                  hamaDanPenyakitSearchedList[index]['gambar_path'] ?? '',
                  hamaDanPenyakitSearchedList[index]['nama'] ?? '',
                  hamaDanPenyakitSearchedList[index]['deskripsi'] ?? '',
                );
              },
            );
          }
        }
      },
    );
  }

  Widget buildContentCard(id, fileName, nama, deskripsi) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: whiteContainerColor,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 0,
              width: 0,
              child: Text(id),
            ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: whiteBackgroundColor,
                    child: Image(
                      image: NetworkImage(Global.serverUrl +
                          Global.imgHamaDanPenyakitPath +
                          fileName),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nama,
                        style: TextStyle(
                          fontWeight: semiBold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Fase Pemupukan', // Ganti dengan keterangan sesuai konten
                        style: BlackTextStyle.copyWith(
                          fontSize: 11,
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          deskripsi, // Ganti dengan informasi sesuai konten
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
                          hamaDanPenyakitChoosedList =
                              hamaDanPenyakitList.where((hamaDanPenyakit) {
                            String id = hamaDanPenyakit['id'];

                            return id.contains(id);
                          }).toList();
                          // debugPrint(jsonEncode(padiList));
                          // debugPrint(jsonEncode(padiChoosedList));
                          // The argument type 'String' can't be assigned to the parameter type 'int'
                          // debugPrint(VarietasPadiPage._id);
                          setPadiChoosed();
                          Get.toNamed('/read-spk'); // Add navigation here
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

  Widget buildMapPanel() {
    return Container(
      child: MapGoogle(),
    );
  }

  Future<void> readHamaDanPenyakit() async {
    final url = Global.serverUrl + Global.readHamaDanPenyakitPath;
    try {
      Response response = await Dio().get(url);
      final body = response.data;
      var stringResponse = body.toString();
      var responseData = stringResponse.replaceAll('{', '').replaceAll('}', '');
      // debugPrint('berhasil 1');
      if (response.statusCode == 200) {
        // debugPrint(stringResponse);
        if (body.containsKey('data')) {
          hamaDanPenyakitList = body['data'] as List<dynamic>;
          debugPrint(hamaDanPenyakitList.toString());
        } else {
          _showWarningSnackBar(context, 'Data key not found');
        }
      } else {
        _showWarningSnackBar(
            context, 'Response status code: ${response.statusCode}');
      }
    } catch (error) {
      _showWarningSnackBar(context, error.toString());
    }
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
                        controller: searchController,
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
                      searchHamaDanPenyakit();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void searchHamaDanPenyakit() {
    // Mendapatkan teks yang dimasukkan pengguna pada TextField
    String searchText = searchController.text.toLowerCase();

    // Menerapkan filter pada daftar padi berdasarkan teks pencarian
    List<dynamic> filteredList = hamaDanPenyakitList.where((hamaDanPenyakit) {
      String nama = hamaDanPenyakit['nama'].toLowerCase();

      // Return true jika nama padi atau kategori mengandung teks pencarian
      return nama.contains(searchText);
    }).toList();
    // debugPrint('cek 10');
    setState(() {
      hamaDanPenyakitSearchedList = filteredList;
    });
  }

  void setPadiChoosed() {
    AnalisisSpkPage.id = hamaDanPenyakitChoosedList[0]['id'].toString();
    AnalisisSpkPage.nama = hamaDanPenyakitChoosedList[0]['nama'].toString();
    AnalisisSpkPage.deskripsi =
        hamaDanPenyakitChoosedList[0]['deskripsi'].toString();
    AnalisisSpkPage.penanggulangan =
        hamaDanPenyakitChoosedList[0]['penanggulangan'].toString();
    AnalisisSpkPage.gambarPath =
        hamaDanPenyakitChoosedList[0]['gambar_path'].toString();
        debugPrint(AnalisisSpkPage.gambarPath);
    AnalisisSpkPage.createdAt =
        hamaDanPenyakitChoosedList[0]['created_at'].toString();
  }

}
