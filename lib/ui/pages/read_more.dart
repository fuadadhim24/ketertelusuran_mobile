import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';

class ReadMorePage extends StatelessWidget {
  const ReadMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Baca Selengkapnya',
          style: TextStyle(
            fontFamily: 'NYTCheltenham',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              height: 200,
              // Isi gambar berita di sini
            ),
            SizedBox(height: 24),
            CustomFilledButton(
              title: 'Pilih Varietas Padi',
              onPressed: () {
                Get.toNamed('/tambah-varietas-padi');
              },
            ),
            SizedBox(height: 32),
            Text(
              'Ciherang',
              style: TextStyle(
                fontFamily: 'NYTCheltenham',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              _generateArticleDescription(),
              style: TextStyle(
                fontFamily: 'NYTFutura',
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Penulis: Rizky Pradika',
              style: TextStyle(
                fontFamily: 'NYTFutura',
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Ditambahkan pada 7 April 2024',
              style: TextStyle(
                fontFamily: 'NYTFutura',
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 8),
            Text(
              'Foto Varietas Padi',
              style: TextStyle(
                fontFamily: 'NYTFutura',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: greenColor,
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildInfoCard(
                    imageUrl: 'assets/image1.jpg',
                    title: 'Informasi 1',
                  ),
                  SizedBox(width: 20),
                  _buildInfoCard(
                    imageUrl: 'assets/image2.jpg',
                    title: 'Informasi 2',
                  ),
                  SizedBox(width: 20),
                  _buildInfoCard(
                    imageUrl: 'assets/image3.jpg',
                    title: 'Informasi 3',
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  String _generateArticleDescription() {
    return '''Varietas padi adalah berbagai jenis atau varietas dari tanaman padi yang ditanam di berbagai daerah di seluruh dunia. Setiap varietas padi memiliki karakteristik unik yang membedakannya dari varietas lainnya. Beberapa varietas padi dikenal karena ketahanannya terhadap penyakit tertentu atau kondisi lingkungan yang ekstrem.

Memilih varietas padi yang tepat merupakan langkah penting.''';
  }

  Widget _buildInfoCard({required String imageUrl, required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          // Placeholder gambar
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'NYTFutura',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
