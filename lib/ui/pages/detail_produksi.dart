import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';
import 'package:ketertelusuran_mobile/ui/widgets/buttons.dart';

class DetailProduksiPage extends StatelessWidget {
  const DetailProduksiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        title: Text(
          'Detail Produksi',
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
              child: Icon(
                Icons.image,
                size: 100,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Ciherang',
              style: TextStyle(
                fontFamily: 'NYTCheltenham',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            _buildDetailItem(
                Icons.agriculture, 'Sumber Benih', 'UD. Tani Rejo'),
            _buildDetailItem(
                Icons.scatter_plot_outlined, 'Tingkat Kemurnian', '98%'),
            _buildDetailItem(Icons.verified, 'Tingkat Vigor', '95%'),
            _buildDetailItem(Icons.scatter_plot, 'Jumlah Benih', '150 kg'),
            SizedBox(height: 20),
            Text(
              'Daftar Petani',
              style: TextStyle(
                fontFamily: 'NYTFutura',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: greenColor,
              ),
            ),
            SizedBox(height: 10),
            _buildpetaniList(['Pak Fuad', 'Pak Rizky', 'Pak Farhan']),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 28,
            color: Colors.blue,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'NYTFutura',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'NYTFutura',
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildpetaniList(List<String> farmers) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: farmers.map((farmer) {
          return ListTile(
            leading: Icon(Icons.person, color: Colors.green),
            title: Text(
              farmer,
              style: TextStyle(
                fontFamily: 'NYTFutura',
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
