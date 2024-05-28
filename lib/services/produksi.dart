import 'package:flutter/foundation.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';

class Produksi{
  static Map<String, dynamic> produksiChoosedList={};
  static int? currentDays;
  static Future<void> readProduksiChoosed(idLahan) async {
    Produksi.produksiChoosedList = HomePage.produksiList.firstWhere(
      (produksi) => produksi['id_lahan'] == idLahan,
      orElse: () => ['null'],
    );
    // debugPrint(Produksi.produksiChoosedList.toString());
    String tanggalProduksiString = produksiChoosedList['tanggal_produksi'];
    currentDays = calculateCurrentDays(tanggalProduksiString)+1;
    // debugPrint(currentDays.toString());
  }

  static int calculateCurrentDays(tanggalProduksiString){
    DateTime tanggalProduksi = DateTime.parse(tanggalProduksiString);
    Duration differenceDay = DateTime.now().difference(tanggalProduksi);
    int daysDuringProduksi = differenceDay.inDays + 1;
    return daysDuringProduksi;
  }
}