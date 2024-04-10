import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';

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
            Get.toNamed('/varietas-padi');
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
            SizedBox(height: 20),
            Text(
              'Varietas Padi',
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
            SizedBox(height: 5),
            Text(
              'Ditambahkan pada tanggal 7 April 2024',
              style: TextStyle(
                fontFamily: 'NYTFutura',
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Baca Informasi Lainnya',
              style: TextStyle(
                fontFamily: 'NYTFutura',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blue,
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
          ],
        ),
      ),
    );
  }

  String _generateArticleDescription() {
    return '''Varietas padi adalah berbagai jenis atau varietas dari tanaman padi yang ditanam di berbagai daerah di seluruh dunia. Setiap varietas padi memiliki karakteristik unik yang membedakannya dari varietas lainnya. Beberapa varietas padi dikenal karena ketahanannya terhadap penyakit tertentu atau kondisi lingkungan yang ekstrem.

Memilih varietas padi yang tepat merupakan langkah penting dalam meningkatkan hasil panen dan produktivitas pertanian. Petani perlu mempertimbangkan berbagai faktor seperti kondisi tanah, iklim, dan kebutuhan pasar sebelum memutuskan varietas yang akan ditanam. Beberapa varietas padi unggulan telah dikembangkan melalui riset dan seleksi genetik untuk meningkatkan hasil panen dan kualitas gabah.

Dalam beberapa tahun terakhir, terjadi peningkatan jumlah varietas padi baru yang dirilis ke pasar. Ini disebabkan oleh perkembangan teknologi pertanian dan penemuan baru dalam bidang genetika tanaman. Varietas padi baru sering kali memiliki keunggulan tertentu seperti daya tahan terhadap hama dan penyakit, kemampuan adaptasi terhadap perubahan iklim, atau hasil panen yang lebih tinggi.''';
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
