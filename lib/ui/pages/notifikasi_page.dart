import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({Key? key}) : super(key: key);

  @override
  _NotifikasiPageState createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  int selectedOption = 0;
  bool allRead = false; // Flag to track if all notifications are read

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        title: Text('Notifikasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Pengingat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildOption('Hari ini', isSelected: selectedOption == 0),
                    buildOption('Besok', isSelected: selectedOption == 1),
                    buildOption('Akan Datang', isSelected: selectedOption == 2),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        10,
                        (index) => Column(
                          children: [
                            buildNotifikasiItem(
                              judul: 'Judul Notifikasi ${index + 1}',
                              isi: 'Isi notifikasi ${index + 1}',
                              tanggal:
                                  '${index + 24} April 2024', // Contoh tanggal
                              sudahDibaca: allRead,
                            ),
                            if (index < 9)
                              Divider(), // Add divider between items except the last one
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    allRead = true; // Mark all notifications as read
                  });
                },
                onDoubleTap: () {
                  setState(() {
                    allRead = false; // Mark all notifications as unread
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Pengingat telah dibaca semua',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: greenColor,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black26,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 20,
              right: 20,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      'Next Update JejakPadi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: semiBold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black26,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOption(String option, {bool isSelected = false}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedOption = ['Hari ini', 'Besok', 'Akan Datang'].indexOf(option);
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

  Widget buildNotifikasiItem({
    required String judul,
    required String isi,
    required String tanggal,
    required bool sudahDibaca,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: greenColor, // Ubah warna latar belakang menjadi hijau
        child: Icon(Icons.notifications,
            color: Colors.white), // Ubah warna ikon menjadi putih
      ),
      title: Text(judul),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(isi),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tanggal,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              if (sudahDibaca)
                Text(
                  'Sudah Dibaca',
                  style: TextStyle(
                    fontSize: 12,
                    color: greenColor,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
