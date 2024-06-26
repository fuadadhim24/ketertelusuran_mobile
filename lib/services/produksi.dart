import 'package:flutter/foundation.dart';
import 'package:ketertelusuran_mobile/services/fase.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';

class Produksi {
  static Map<String, dynamic> produksiChoosedList = {};
  static Map<String, dynamic> produksiNonPanenChoosedList = {};
  static int? currentDays;
  static Future<void> readProduksiPanenChoosed(idLahan, panenList) async {
    currentDays = null;
    Fase.namaFase = '';
    produksiNonPanenChoosedList.clear();

    // debugPrint(HomePage.panenList.toString());
    // debugPrint(HomePage.produksiList.toString());
    produksiChoosedList = HomePage.produksiList.firstWhere(
      (produksi) => produksi['id_lahan'] == idLahan,
      orElse: () => {'null': 'null'},
    );
    // debugPrint('Produksi Choosed List: $produksiChoosedList');
    // panenList.forEach((panen) {
    //     if (produksiChoosedList['id'] != panen['id_produksi']) {

    //     }
    //   });
    // Produksi.produksiNonPanenChoosedList = Produksi.produksiNonPanenChoosedList.
    // debugPrint(panenList.toString());
    // debugPrint(Produksi.produksiChoosedList.toString());
    // debugPrint(Produksi.produksiAllChoosedList.toString());
    for (var produksi in HomePage.produksiList) {
      if (!panenList.any((panen) => panen['id_produksi'] == produksi['id'])) {
        produksiNonPanenChoosedList = produksi;
      }
    }
    debugPrint(produksiNonPanenChoosedList.toString());
    debugPrint(idLahan.toString());
    if (produksiNonPanenChoosedList['id_lahan'] == idLahan) {
      // debugPrint(Produksi.produksiNonPanenChoosedList.toString());
      String tanggalProduksiString =
          produksiNonPanenChoosedList['tanggal_produksi'];
      currentDays = calculateCurrentDays(tanggalProduksiString);
      HomePage.idProduksi = produksiNonPanenChoosedList['id'];
      // debugPrint('Current Days: $currentDays');
      // debugPrint(produksiNonPanenChoosedList['id']);
      // FASE
      await Produksi.pencatatanChoosedProduksi(
          produksiNonPanenChoosedList['id']);
      if (currentDays != null) {
        Fase.readFaseChoosed(currentDays);
      }

      HomePage.spkTitle = 'S';
      HomePage.spkSubTitle = 'S';
    } else {
      currentDays = 0;
      HomePage.spkTitle = '';
      HomePage.spkSubTitle = '';
      Fase.namaFase = "";
      produksiNonPanenChoosedList = {'null': 'null'};
    }
  }

  static int calculateCurrentDays(tanggalProduksiString) {
    DateTime tanggalProduksi = DateTime.parse(tanggalProduksiString);
    Duration differenceDay = DateTime.now().difference(tanggalProduksi);
    int daysDuringProduksi = differenceDay.inDays + 1;
    return daysDuringProduksi;
  }

  static Future<void> pencatatanChoosedProduksi(String idProduksi) async {
    for (var item in HomePage.pencatatanList) {
      if (item.containsKey('id_produksi') &&
          item['id_produksi'] == idProduksi) {
        HomePage.pencatatanProduksiChoosedList.add(item);
      }
    }
    // debugPrint(HomePage.pencatatanProduksiChoosedList.toString());
  }
}
