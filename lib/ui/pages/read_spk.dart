import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/global.dart';
import 'package:ketertelusuran_mobile/ui/pages/analisis_spk_page.dart';

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
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              width: double.infinity,
              height: 200,
              child: Image(
                image: NetworkImage(Global.serverUrl +
                    Global.imgHamaDanPenyakitPath +
                    AnalisisSpkPage.gambarPath),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 24),
            Text(
              AnalisisSpkPage.nama,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 8),
            Text(
              AnalisisSpkPage.deskripsi,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
