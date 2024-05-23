import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/pages/varietas_padi_page.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';

class ReadMorePage extends StatefulWidget {
  ReadMorePage({super.key});

  @override
  State<ReadMorePage> createState() => _ReadMorePageState();
}

class _ReadMorePageState extends State<ReadMorePage> {
  String? id = VarietasPadiPage.id;
  String? varietas = VarietasPadiPage.varietas;
  String? karakteristikHasil = VarietasPadiPage.karakteristikHasil;
  String? kategori = VarietasPadiPage.kategori;
  String? deskripsi = VarietasPadiPage.deskripsi;
  String? keunggulan = VarietasPadiPage.keunggulan;
  String? jenisMusim = VarietasPadiPage.jenisMusim;
  String? lamaTanam = VarietasPadiPage.lamaTanam;
  String? ketahananHamaPenyakit = VarietasPadiPage.ketahananHamaPenyakit;
  String? deletedAt = VarietasPadiPage.deletedAt;
  String? createdAt = VarietasPadiPage.createdAt;
  String? updateAt = VarietasPadiPage.updateAt;
  @override
  Widget build(BuildContext context) {
    // final padi = padiList.firstWhere((padi) => padi['id'] == id);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Varietas Padi',
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
              varietas ?? '',
              style: BlackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              karakteristikHasil ?? '',
              style: BlackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 8),
            CustomFilledButton(
              title: 'Pilih Varietas Padi',
              onPressed: () {
                Get.toNamed('/tambah-varietas-padi');
              },
            ),
            SizedBox(height: 20),
            Text(
              deskripsi ?? '',
              style: BlackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 36),
            Text(
              'Keunggulan',
              style: BlackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              keunggulan ?? '',
              style: BlackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 8),
            Text(
              'Jenis Musim',
              style: BlackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            Text(
              jenisMusim ?? '',
              style: BlackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Durasi Tanam hingga panen',
              style: BlackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              lamaTanam ?? '',
              style: BlackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Ketahanan Pada Hama dan Penyakit',
              style: BlackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            Text(
              ketahananHamaPenyakit ?? '',
              style: BlackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              createdAt ?? '',
              style: TextStyle(
                fontFamily: 'NYTFutura',
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 3),
            Text(
              updateAt ?? '',
              style: TextStyle(
                fontFamily: 'NYTFutura',
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

}
