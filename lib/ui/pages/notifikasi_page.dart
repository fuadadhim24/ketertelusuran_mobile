import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Notifikasi'
          ),
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/notifikasi');
                  },
                  child: Text('Hari Ini'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/notifikasi');
                  },
                  child: Text('Minggu Lalu'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/notifikasi');
                  },
                  child: Text('Akan Datang'),
                ),
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

  Widget buildNotifikasiItem({
    required String judul,
    required String isi,
    required String tanggal,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
            greenColor, // Ubah warna latar belakang menjadi hijau
        child: Icon(Icons.notifications,
            color: Colors.white), // Ubah warna ikon menjadi putih
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
