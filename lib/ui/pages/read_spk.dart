import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadSPK extends StatelessWidget {
  const ReadSPK({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Informasi Analisis SPK',
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
            SizedBox(height: 24),
            Text(
              'Wereng',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Fase Pemupukan',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 8),
            Text(
              'Wereng adalah salah satu hama utama pada tanaman padi. Hama ini dapat menyebabkan kerugian yang signifikan pada hasil panen dan berpotensi menghambat pertumbuhan tanaman secara keseluruhan. Wereng biasanya menyerang tanaman padi pada fase pemupukan dan berbahaya jika tidak dikendalikan dengan tepat.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 36),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Penulis: Rizky Pradika',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  'Tanggal: 9 Juni 2024',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
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
