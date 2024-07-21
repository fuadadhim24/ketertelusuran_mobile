import 'package:flutter/foundation.dart';
import 'package:ketertelusuran_mobile/services/fase.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';

class Produksi {
  static Map<String, dynamic> produksiChoosedList = {};
  static Map<String, dynamic> produksiNonPanenChoosedList = {}; // Inisialisasi
  static int? currentDays;

  static Future<void> readProduksiPanenChoosed(idLahan, panenList) async {
    currentDays = null;
    Fase.namaFase = '';
    Fase.namaPerlakuan  = '';

    // Pastikan inisialisasi jika belum diinisialisasi
    if (produksiNonPanenChoosedList == null) {
      produksiNonPanenChoosedList = {};
    } else {
      produksiNonPanenChoosedList
          .clear(); // Bersihkan jika sudah ada data sebelumnya
    }

    produksiChoosedList = HomePage.produksiList.firstWhere(
      (produksi) => produksi['id_lahan'] == idLahan,
      orElse: () => {'null': 'null'},
    );

    for (var produksi in HomePage.produksiList) {
      if (!panenList.any((panen) => panen['id_produksi'] == produksi['id'])) {
        produksiNonPanenChoosedList.addAll(
            produksi); // Gunakan .addAll() untuk menambahkan data ke Map
      }
    }

    if (produksiNonPanenChoosedList.isNotEmpty &&
        produksiNonPanenChoosedList['id_lahan'] == idLahan) {
      String tanggalProduksiString =
          produksiNonPanenChoosedList['tanggal_produksi'];
      currentDays = calculateCurrentDays(tanggalProduksiString);
      HomePage.idProduksi = produksiNonPanenChoosedList['id'];

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

  static int calculateCurrentDays(String tanggalProduksiString) {
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
  }
}
