import 'package:flutter/foundation.dart';
import 'package:ketertelusuran_mobile/ui/pages/home_page.dart';

class Fase {
  static double? totalDurasi;
  static Map<String, List<Map<String, dynamic>>> categorizedValuesMap = {};
  static void readFaseChoosed() {
    // debugPrint(HomePage.faseDanPerlakuanList.toString());
    totalDurasi = hitungTotalDurasi(HomePage.faseDanPerlakuanList);
    categorizedValuesMap = faseCategorize(HomePage.faseDanPerlakuanList);
    debugPrint(totalDurasi.toString());
    debugPrint(categorizedValuesMap.toString());
  }

  static double hitungTotalDurasi(List<dynamic> list) {
    Set<String> uniqueFaseNames = {};
    double totalDurasi = 0;

    list.forEach((value) {
      if (!uniqueFaseNames.contains(value['nama_fase'])) {
        double durasi = double.parse(value['durasi']);
        totalDurasi += durasi;
        uniqueFaseNames.add(value['nama_fase']);
      }
    });
    return totalDurasi;
  }

  static Map<String, List<Map<String, dynamic>>> faseCategorize(
      List<dynamic> list) {
    Map<String, List<Map<String, dynamic>>> categorizedValues = {};

    list.forEach((value) {
      String faseName = value['nama_fase'];

      if (!categorizedValues.containsKey(faseName)) {
        categorizedValues[faseName] = [];
      }

      categorizedValues[faseName]?.add(value);
    });

    return categorizedValues;
  }
}
