import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Response;
import 'package:ketertelusuran_mobile/services/auth.dart';
import 'package:ketertelusuran_mobile/services/fase.dart';
import 'package:ketertelusuran_mobile/services/produksi.dart';
import 'package:ketertelusuran_mobile/shared/global.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/pages/tambah_lahan_page.dart';
import 'package:ketertelusuran_mobile/ui/pages/varietas_padi_page.dart';
import 'package:ketertelusuran_mobile/ui/widgets/home_service_item.dart';
import 'package:ketertelusuran_mobile/ui/pages/notifikasi_page.dart';

class HomePage extends StatefulWidget {
  static String idLahan = '';
  static String detailLokasi = '';
  static String luas = '';
  static String latitude = '';
  static String longitude = '';
  static String jenisTanah = '';
  static List<dynamic> lahanList = [];
  static List<dynamic> produksiList = [];
  static Map<String, dynamic> produksiChoosedList = {};
  static List<dynamic> faseDanPerlakuanList = [];
  static List<dynamic> pencatatanList = [];
  static String namaLahan = '';
  static String? namaPadi;
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? idPadi = Produksi.produksiChoosedList['id_padi'].toString();
  List<dynamic> padiList = [];
  bool _isLoaded = false;
  final dio = Dio();

  @override
  void initState() {
    readPadi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? Scaffold(
            backgroundColor: whiteBackgroundColor,
            drawer: buildSidebar(), // Menggunakan Drawer untuk sidebar
            body: Row(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    children: [
                      buildHomeHeading(context),
                      buildCultivation(),
                      buildServices(context),
                      buildNotes(),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : FutureBuilder(
            future: readHomePage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Scaffold(
                  backgroundColor: whiteBackgroundColor,
                  drawer: buildSidebar(), // Menggunakan Drawer untuk sidebar
                  body: Row(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          children: [
                            buildHomeHeading(context),
                            buildCultivation(),
                            buildServices(context),
                            buildNotes(),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
  }

  Widget buildSidebar() {
    return Drawer(
      child: Container(
        width: 180, // Increased width of the Drawer
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ic_logo_2.png'),
                ),
              ),
            ),
            // Tambah Lahan Button
            InkWell(
              onTap: () {
                Get.toNamed('/tambah-lahan')?.then((value) => {
                      TambahLahanPage.resultLatitude = null,
                      TambahLahanPage.resultLongitude = null,
                    });
              },
              child: Container(
                width: 180, // Increased width of the Tambah Lahan Button
                height: 50, // Increased height of the Tambah Lahan Button
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), // Rounded corners
                  color: greenColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.landscape, color: Colors.white),
                    Text(
                      'Tambah Lahan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.add, color: Colors.white),
                  ],
                ),
              ),
            ),
            // Pembatas
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[400],
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
            // Text Tambah Sawah
            Text(
              'Daftar Sawah',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Pembatas
            Container(
              height: 1,
              width: double.infinity,
              color: greenColor,
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
            // List Lahan Sawah
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: HomePage.lahanList.map((lahan) {
                  // Ambil nama lahan dari objek lahan
                  final String namaLahan = lahan['nama_lahan'];

                  return buildLahanButton(namaLahan);
                }).toList(),
              ),
            ),
            // Jarak antara daftar sawah dan tombol Riwayat Produksi
            SizedBox(height: 20),
            // Riwayat Produksi Button
            InkWell(
              onTap: () {
                Get.toNamed('/riwayat-produksi');
              },
              child: Container(
                width: 180, // Increased width of the Riwayat Produksi Button
                height: 50, // Increased height of the Riwayat Produksi Button
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), // Rounded corners
                  color: greenColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.history, color: Colors.white),
                    Text(
                      'Riwayat Produksi',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),
            // Jarak antara tombol Riwayat Produksi dan tombol Keluar
            SizedBox(height: 20),
            // Keluar Button
            GestureDetector(
              onTap: () {
                Auth authOption = Auth();
                authOption.signOut();
              },
              child: Container(
                width: 160, // Increased width of the Keluar Button
                height: 50, // Match parent width
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), // Rounded corners
                  color: greenColor, // Green background color
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.exit_to_app, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Keluar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White text color
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLahanButton(String lahanName) {
    return GestureDetector(
      child: Container(
        width: 120, // Increased width of the Lahan buttons
        height: 50, // Increased height of the Lahan buttons
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), // Rounded corners
          color: Colors.grey[300],
        ),
        child: Row(
          children: [
            SizedBox(width: 10), // Add padding to the left of the icon
            Icon(Icons.landscape, color: greenColor), // Material icon
            SizedBox(width: 10), // Add space between icon and text
            Text(
              lahanName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      onTap: () => lahanChoosed(lahanName),
    );
  }

  Widget buildHomeHeading(context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 54,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/ic_menu.png'),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Text(
                HomePage.namaLahan,
                textAlign: TextAlign.center,
                style: BlackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Routing ke halaman NotifikasiPage
                  Get.toNamed('/notifikasi');
                },
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/ic_notification.png',
                      ),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: RedColor,
                      ),
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

  Widget buildCultivation() {
    return Container(
      margin: EdgeInsets.only(
        top: 36,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 199,
                  decoration: BoxDecoration(
                    color: whiteContainerColor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sumbersari, Jember',
                        style: BlackTextStyle.copyWith(
                          fontSize: 15,
                          fontWeight: semiBold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Container(
                        width: 63,
                        height: 63,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: yellowColor,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        '37°',
                        style: BlackTextStyle.copyWith(
                          fontSize: 32,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        'Terang Benderang',
                        style: BlackTextStyle.copyWith(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 94,
                      decoration: BoxDecoration(
                        color: whiteContainerColor,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Fase Budidaya',
                            style: BlackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Fase.namaFase != "" ? 
                          Text(
                            Fase.namaFase,
                            style: BlackTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ) :
                          Text(
                            'Lahan tidak digunakan',
                            style: redTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 94,
                      decoration: BoxDecoration(
                        color: whiteContainerColor,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Suhu',
                            style: BlackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '17°',
                                style: BlackTextStyle.copyWith(
                                  fontSize: 36,
                                  fontWeight: semiBold,
                                ),
                              ),
                              Text(
                                'celcius',
                                style: BlackTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 86,
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteContainerColor,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Waspada Terhadap Ilalang',
                  style: BlackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Rekomendasi bersihkan 1/2 bulan sekali',
                  style: BlackTextStyle.copyWith(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildServices(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fitur',
            style: BlackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          Text(
            'Manajemen',
            style: BlackTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 101,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomHomeService(
                      title: 'Penyemaian',
                      iconUrl: 'assets/ic_seedling.png',
                      onTap: () {
                        // Routing ke halaman VarietasPadiPage
                        // debugTesting();
                        Get.toNamed('/varietas-padi');
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CustomHomeService(
                      title: 'Penanaman',
                      iconUrl: 'assets/ic_varietas.png',
                      onTap: () {
                        // Routing ke halaman VarietasPadiPage
                        // debugTesting();
                        if(Fase.namaFase != ""){
                          Get.toNamed('/penanaman');
                        }else{
                          _showWarningSnackBar(context, 'Lakukan penyemaian terlebih dahulu');
                        }
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CustomHomeService(
                      title: 'Perawatan',
                      iconUrl: 'assets/ic_grade.png',
                      onTap: () {
                        if(Fase.namaFase != ""){
                          Get.toNamed('/perawatan');
                        }else{
                          _showWarningSnackBar(context, 'Lakukan penyemaian terlebih dahulu');
                        }
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CustomHomeService(
                      title: 'Analisis SPK',
                      iconUrl: 'assets/ic_ketertelusuran.png',
                      onTap: () {
                        Get.toNamed('/analisis-spk');
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CustomHomeService(
                      title: 'Panen',
                      iconUrl: 'assets/ic_lahan_big.png',
                      onTap: () {
                        if(Fase.namaFase != ""){
                          Get.toNamed('/panen');
                        }else{
                          _showWarningSnackBar(context, 'Lakukan penyemaian terlebih dahulu');
                        }
                      },
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

  Widget buildNotes() {
    return Container(
      margin: const EdgeInsets.only(
        top: 50,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ketertelusuran Beras Anda',
                    style: BlackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Optimalisasi jaminan mutu',
                    style: BlackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Container(
                width: 94,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: whiteContainerColor,
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
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 189),
            decoration: BoxDecoration(
              color: whiteContainerColor,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Riwayat Pencatatan',
                      style: BlackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/pencatatan');
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/ic_add_circle.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 22,
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
                          Fase.namaFase != "" ? ('Fase '+Fase.namaFase) : '__',
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
                const SizedBox(
                  height: 18,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ExpansionTile(
                        maintainState: true,
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        title: Text("Perawatan $index"),
                        children: [
                          const Text(
                            "Jenis Perawatan: Pemupukan",
                            textAlign: TextAlign.left,
                          ),
                          const Text(
                            "Nama Perawatan: NPK 32",
                            textAlign: TextAlign.left,
                          ),
                          const Text(
                            "Jumlah: 10",
                            textAlign: TextAlign.left,
                          ),
                          const Text(
                            "Kebutuhan: Mempercepat Pertumbuhan",
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
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

  Future<void> readLahan() async {
    final url = Global.serverUrl + Global.readLahanPath;
    final finalUrl = url;
    Response response;
    response = await dio.get(finalUrl);
    final body = response.data;
    var stringResponse = body.toString();
    var responseData = stringResponse.replaceAll('{', '').replaceAll('}', '');
    if (response.statusCode == 200) {
      if (body.containsKey('data')) {
        // _showSuccessSnackBar(context,'Berhasil Mendapatkan Data Lahan');
        // debugPrint(jsonEncode(body));
        // debugPrint('lahanList : $lahanList');

        HomePage.lahanList = body['data'];
        lahanDefault();
      } else {
        _showWarningSnackBar(context, responseData);
      }
    } else {
      _showWarningSnackBar(context, responseData);
    }
  }

  // produksi, pencatatan, fase dan perlakuan
  Future<void> readHomePage() async {
    readLahan();
    final url = Global.serverUrl + Global.mainPath + Global.homePagePath;
    final finalUrl = url;
    Response response;
    response = await dio.get(finalUrl);
    final body = response.data;
    var stringResponse = body.toString();
    var responseData = stringResponse.replaceAll('{', '').replaceAll('}', '');
    if (response.statusCode == 200) {
      if (body.containsKey('produksi') &&
          body.containsKey('pencatatan') &&
          body.containsKey('fase_dan_perlakuan_utama')) {
        // _showSuccessSnackBar(context,'Berhasil Mendapatkan Data Lahan');
        _isLoaded = true;
        HomePage.produksiList = body['produksi']['produksi'];
        HomePage.pencatatanList = body['pencatatan']['pencatatan'];
        HomePage.faseDanPerlakuanList =
            body['fase_dan_perlakuan_utama']['fase_dan_perlakuan_utama'];
        if (HomePage.produksiList.isNotEmpty &&
            HomePage.pencatatanList.isNotEmpty &&
            HomePage.faseDanPerlakuanList.isNotEmpty) {
          // debugPrint(HomePage.produksiList.toString());
          // debugPrint(HomePage.idLahan);
          // debugPrint(HomePage.faseDanPerlakuanList.toString());

          // PRODUKSI
          await Produksi.readProduksiChoosed(HomePage.idLahan);
          


          _isLoaded = true;
        }
      } else {
        _showWarningSnackBar(context, responseData);
      }
    } else {
      _showWarningSnackBar(context, responseData);
    }
  }

  void lahanDefault() {
    if (HomePage.lahanList.isNotEmpty) {
      // Ambil nilai dari elemen pertama dalam lahanList
      HomePage.idLahan = HomePage.lahanList[0]['id'];
      HomePage.namaLahan = HomePage.lahanList[0]['nama_lahan'];
      HomePage.detailLokasi = HomePage.lahanList[0]['detail_lokasi'];
      HomePage.luas = HomePage.lahanList[0]['luas'];
      HomePage.latitude = HomePage.lahanList[0]['latitude'];
      HomePage.longitude = HomePage.lahanList[0]['longitude'];
      HomePage.jenisTanah = HomePage.lahanList[0]['jenis_tanah'];
    } else {
      debugPrint('data lahan pertama tidak bisa didapatkan');
    }
  }

  void lahanChoosed(String chosenNamaLahan) {
    var chosenLahan = HomePage.lahanList.firstWhere(
      (lahan) => lahan['nama_lahan'] == chosenNamaLahan,
      orElse: () => null,
    );

    if (chosenLahan != null) {
      debugPrint(HomePage.namaLahan);
      debugPrint(HomePage.detailLokasi);
      setState(() {
        HomePage.idLahan = chosenLahan['id'];
        HomePage.namaLahan = chosenLahan['nama_lahan'];
        HomePage.detailLokasi = chosenLahan['detail_lokasi'];
        HomePage.luas = chosenLahan['luas'];
        HomePage.latitude = chosenLahan['latitude'];
        HomePage.longitude = chosenLahan['longitude'];
        HomePage.jenisTanah = chosenLahan['jenis_tanah'];

        // PRODUKSI
        Produksi.readProduksiChoosed(HomePage.idLahan);
        
      });
      Get.back();
    } else {
      _showWarningSnackBar(context, 'Gagal mendapatkan data lahan spesifik');
    }
  }

  void debugTesting() {
    debugPrint(HomePage.idLahan);
    debugPrint(HomePage.namaLahan);
    debugPrint(HomePage.detailLokasi);
    debugPrint(HomePage.luas);
    debugPrint(HomePage.latitude);
    debugPrint(HomePage.longitude);
    debugPrint(HomePage.jenisTanah);
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
          // debugPrint(Produksi.produksiChoosedList.toString());
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
      HomePage.namaPadi = choosedPadi['varietas'].toString();
    } else {
      // Jika tidak ditemukan, set namaPadi ke null atau string kosong, sesuai kebutuhan aplikasi Anda
      HomePage.namaPadi = 'Anda belum menentukan penyemaian'; // atau namaPadi = '';
    }
    // debugPrint(choosedPadi.toString());
    // debugPrint(idPadi.toString());
  }
}
