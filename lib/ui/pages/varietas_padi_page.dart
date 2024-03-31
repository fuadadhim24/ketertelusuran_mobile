import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/widgets/home_service_item.dart';

class VarietasPadiPage extends StatefulWidget {
  const VarietasPadiPage({Key? key}) : super(key: key);

  @override
  _VarietasPadiPageState createState() => _VarietasPadiPageState();
}

class _VarietasPadiPageState extends State<VarietasPadiPage> {
  bool isRainySeason = true; // Default is rainy season
  int selectedOption = 0; // Default selected option is "Semua"

  void toggleSeason() {
    setState(() {
      isRainySeason = !isRainySeason;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        children: [
          buildHomeHeading(),
          SizedBox(
            height: 30,
          ),
          buildNotes(),
          SizedBox(
            height: 30,
          ),
          buildSearchAndFilter(),
          SizedBox(
            height: 30,
          ),
          buildVarietasPadiContent(),
          SizedBox(
            height: 30,
          ),
        ],
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
                    image: AssetImage('assets/ic_menu.png'),
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
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  'Pemilihan Jenis Benih tergantung dari musim yang berlangsung di daerah anda pada 4 bulan kedepan.',
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
                          color: isRainySeason ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.water_drop,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Musim Hujan',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                          color: !isRainySeason ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Musim Kemarau',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
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
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  icon: Icon(Icons.filter_alt, color: Colors.white),
                  onPressed: () {
                    // Tambahkan aksi ketika tombol filter ditekan
                  },
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
            buildOption('Potensial', isSelected: selectedOption == 1),
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
          selectedOption = ['Semua', 'Potensial', 'Selalu', 'Jarang']
              .indexOf(option);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          option,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildVarietasPadiContent() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5, // Ganti dengan jumlah konten yang diinginkan
      itemBuilder: (context, index) {
        return buildContentCard();
      },
    );
  }

  Widget buildContentCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Mengatur border radius gambar
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey, // Ganti dengan gambar sesuai konten
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Judul Konten', // Ganti dengan judul sesuai konten
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Unggulan/Jarang Dipakai', // Ganti dengan keterangan sesuai konten
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          'Informasi singkat mengenai konten tersebut', // Ganti dengan informasi sesuai konten
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          // Tambahkan aksi ketika tombol "Baca Selengkapnya" ditekan
                        },
                        child: Row(
                          children: [
                            Text(
                              'Baca Selengkapnya',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
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
}

