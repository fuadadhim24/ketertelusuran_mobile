import 'package:flutter/material.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';

class Catatan {
  static List<dynamic> catatan = HomePage.pencatatanList;
  static List<dynamic> catatanChoosed = HomePage.pencatatanList;
  static void readCatatanChoosed(idProduksi) {
    catatanChoosed = HomePage.lahanList.firstWhere(
      (produksi) => produksi['id'] == idProduksi,
      orElse: () => null,
    );
    // debugPrint(catatanChoosed.toString());
  }
}
