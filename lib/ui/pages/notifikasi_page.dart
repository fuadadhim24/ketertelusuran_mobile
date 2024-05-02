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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text('Notifikasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
                  children: [
                    buildNotifikasiItem(
                      judul: 'Judul Notifikasi 1',
                      isi: 'Isi notifikasi 1',
                      tanggal: '24 April 2024', // Contoh tanggal
                    ),
                    Divider(),
                    buildNotifikasiItem(
                      judul: 'Judul Notifikasi 2',
                      isi: 'Isi notifikasi 2',
                      tanggal: '25 April 2024', // Contoh tanggal
                    ),
                    Divider(),
                    buildNotifikasiItem(
                      judul: 'Judul Notifikasi 3',
                      isi: 'Isi notifikasi 3',
                      tanggal: '26 April 2024', // Contoh tanggal
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
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: greenColor, // Ubah warna latar belakang menjadi hijau
        child: Icon(Icons.notifications, color: Colors.white), // Ubah warna ikon menjadi putih
      ),
      title: Text(judul),
      subtitle: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isi),
                Text(
                  tanggal,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
